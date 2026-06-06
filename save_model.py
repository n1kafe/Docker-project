import torch
import torchvision.models as models
import os

os.makedirs('model', exist_ok=True)

model = models.resnet18(weights=models.ResNet18_Weights.DEFAULT)
model.eval()

dummy_input = torch.rand(1, 3, 224, 224)

traced_model = torch.jit.trace(model, dummy_input)

traced_model.save("model/traced_model.pt")

print("Model saved to model/traced_model.pt")