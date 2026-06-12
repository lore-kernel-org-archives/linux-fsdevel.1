Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566943D3D02;
	Fri, 12 Jun 2026 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303942; cv=none; b=bvhjYXvY625qsCB1JQcQlWLSxsSti0zLMoV2Ax7NBfb/CHOvLhjjhEYaBQOSA+j2dLYLsCythHDsiFFnsTe4LPM34hpkzX0RxODwgfh2AwdWR+Tt7nDFXAsj71djGYQuaXBuek8GofXWrSNsVOay6WE325qrC9O5NvefjyzarRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303942; c=relaxed/simple;
	bh=cVc2hy2A9f/wwW+jo28hnzjxf9i6e0XD+OrMlXPpgB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAG2VZScYKfpBiBPLsk1DQ7tXxfRTvrEI+x4VnRby3rvFJa0Qls8kN6XKRyUJCY/Uvivn4CjPm/uzp6Q4tU/KtCU0JKbfCsB5XI+Gj8hgxhCCI46bIaZh80YTIiG78dOKBQLl+0hpabJ8rZ5Euh6buitzyq67QplzS4WQn1ObFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XoBBA4gb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XoBBA4gb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E20BD4A0B;
	Fri, 12 Jun 2026 15:38:55 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52F3F3FB7F;
	Fri, 12 Jun 2026 15:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781303940; bh=cVc2hy2A9f/wwW+jo28hnzjxf9i6e0XD+OrMlXPpgB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XoBBA4gb22woOFFqLugh1xWe71wO756b3n6XJsSeVBj5nr9j2yAQhxQ+fkXToDYEf
	 rJ6rloMQgVvX28cWGXYylpznfDzmpCMquNoCNR2UjMo3m2MLHkFgJAIAG3LzqhZHUN
	 knUudm2Wwa2c9flcD4XLVizl45ex+CrwVbr5+be0=
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
	d-gole@ti.com,
	jic23@kernel.org,
	elif.topuz@arm.com,
	lukasz.luba@arm.com,
	philip.radford@arm.com,
	brauner@kernel.org,
	souvik.chakravarty@arm.com,
	leitao@kernel.org,
	kas@kernel.org,
	puranjay@kernel.org,
	usama.arif@linux.dev,
	kernel-team@meta.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v4 06/31] dt-bindings: firmware: arm,scmi: Add support for telemetry protocol
Date: Fri, 12 Jun 2026 23:37:36 +0100
Message-ID: <20260612223802.1337232-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612223802.1337232-1-cristian.marussi@arm.com>
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
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
v3 --> v4
 - changed protocol number to lowercase 1b
 - fixed misplaced block for protocol 0x1b

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index d06cca9273c4..be733f8d60a0 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -324,6 +324,14 @@ properties:
     required:
       - reg
 
+  protocol@1b:
+    $ref: '#/$defs/protocol-node'
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x1b
+
 unevaluatedProperties: false
 
 $defs:
-- 
2.54.0

