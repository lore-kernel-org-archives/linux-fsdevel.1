Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84253815C8;
	Sun, 29 Mar 2026 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802077; cv=none; b=GAEgEN1RCzfYw1dJsjz4YrkmswNObKNBMyrXXNBc/oZo0NDybXJ/j7JP+nhjbvfEjlgAhGUNqEykfA6HNohv9gODCJiDR8fXBot02LzgGM07RQTDi2rKFKELZPhbgZoTQMdqUNTTWu8OKc7CP4G/PTbn+N2RlGtCj/V8T32MDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802077; c=relaxed/simple;
	bh=EakhYDLwrbVeeuChZm85Sn7ds6ALCpPX+l9htovldF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9VI4fu8tvUtPPGt8iBx2ZSMVE7uqnqmLZijH8f72aoWIg+0qMoNJJcaHPuONQU6AdM+0/5YH6uZs8DJFWl6iknS8rEimKTn9DYmEfsvGBiA+6WxEaQRvNKDhqTQvSHsLIPATPE8Uaz+tuA23g6WglLj3IrXB01MsouBWgtJ5TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=n8X6EKHq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="n8X6EKHq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DC403627;
	Sun, 29 Mar 2026 09:34:27 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD4C43F915;
	Sun, 29 Mar 2026 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774802073; bh=EakhYDLwrbVeeuChZm85Sn7ds6ALCpPX+l9htovldF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8X6EKHq4XQo/QrZWa89FFZyTyffgKDG99X+HsABeYMg/BXyXPIbtaxJwj3ss0pCi
	 KOCwMlz5tirOUZHmiUOJRYQnIpzqos/xg5AyzqAliybC5SHNMVR0hggK7WCMz3b+hn
	 CambCBIZ845nlNgIyyRDL2gYngaJ4iEyU5FJdl9s=
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sudeep.holla@kernel.org,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	jonathan.cameron@huawei.com,
	elif.topuz@arm.com,
	lukasz.luba@arm.com,
	philip.radford@arm.com,
	brauner@kernel.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 06/24] dt-bindings: firmware: arm,scmi: Add support for telemetry protocol
Date: Sun, 29 Mar 2026 17:33:17 +0100
Message-ID: <20260329163337.637393-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329163337.637393-1-cristian.marussi@arm.com>
References: <20260329163337.637393-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new SCMI v4.0 Telemetry protocol bindings definitions.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index be817fd9cc34..e936ae7c0fb9 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -298,6 +298,14 @@ properties:
       reg:
         const: 0x19
 
+  protocol@1B:
+    $ref: '#/$defs/protocol-node'
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x1B
+
     patternProperties:
       '-pins$':
         type: object
-- 
2.53.0

