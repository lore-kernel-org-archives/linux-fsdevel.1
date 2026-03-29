Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15006382F15;
	Sun, 29 Mar 2026 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802121; cv=none; b=WAWj8olGNNInC/Jegg4Fle6VpsHO3wq1kZ83+bZQgLkpwnXzfrXa2F9cHB3Nq83Kg8EqY2O2s4VpQwfhMA0hLvQjC1KnvoG/UVLI7/cYFPOVXkdaRkqqp18EhzZcSrkm/mestwSnlDJc5/cvmGrRdzXopvzOo1wWPLb8X6nDJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802121; c=relaxed/simple;
	bh=12M2b0pR7TRv/e5VIWyWPoIDiWGPdvrhSnf79Npz2uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiWotodRMFKvKOMF4jZ7vLreN6UQ2IgLAP0HgYpB8AW24bWDeYu7y+huMuayiM2DDTwulizMhnbulUYMYXyDPNJKh4bdX+M+2QslJGmlfbKbTKhjidQMLS7vv16wtuEiXuepCdVBbJb+Zyua+e0A0edoqHWY9uQPRqoX1L9z7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NjFlSZ18; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NjFlSZ18"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF8C04456;
	Sun, 29 Mar 2026 09:35:13 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6BEA3F915;
	Sun, 29 Mar 2026 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774802119; bh=12M2b0pR7TRv/e5VIWyWPoIDiWGPdvrhSnf79Npz2uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NjFlSZ18d8dK0Geuov8DbbQftOmWIJwvdJ9O8hfg4VuMaX89zneDtq8zahmAHvsK0
	 XpUrhWJD3BMHtrYmEgAtr30Z3MwOLOUCIgeFwZO0K/OomaVWAzYJBnxob9hHC+IHIM
	 dVjIaimGc+J74eIZwuGfYELWCCCkxTRlt5NdrZog=
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
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 20/24] fs/stlmfs: Document alternative topological view
Date: Sun, 29 Mar 2026 17:33:31 +0100
Message-ID: <20260329163337.637393-21-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329163337.637393-1-cristian.marussi@arm.com>
References: <20260329163337.637393-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The human readable interface presents an alternative view based on the
discovered topological relations between the DEs.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2 --> v3
 - completed FS tree description
 - renamed components to by_components
---
 Documentation/filesystems/stlmfs.rst | 72 ++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/filesystems/stlmfs.rst b/Documentation/filesystems/stlmfs.rst
index e4f07a4f930d..a775da24f320 100644
--- a/Documentation/filesystems/stlmfs.rst
+++ b/Documentation/filesystems/stlmfs.rst
@@ -113,6 +113,7 @@ the following directory structure::
 	|-- all_des_enable
 	|-- all_des_tstamp_enable
 	|-- available_update_intervals_ms
+	|-- components/
 	|-- control
 	|-- current_update_interval_ms
 	|-- de_implementation_version
@@ -203,6 +204,77 @@ values, as in::
 	|-- intervals_discrete
 	`-- tstamp_enable
 
+by_components/
+-----------
+
+An alternative topological view of the des/ directory based on the topology
+relationship information described in des/ ::
+
+	by_components/
+	├── cpu
+	│   ├── 0
+	│   │   ├── celsius
+	│   │   │   └── 0
+	│   │   │       └── 0x00000001[pe_0] -> ../../../../../des/0x00000001
+	│   │   └── cycles
+	│   │       ├── 0
+	│   │       │   └── 0x00001010[] -> ../../../../../des/0x00001010
+	│   │       └── 1
+	│   │           └── 0x00002020[] -> ../../../../../des/0x00002020
+	│   ├── 1
+	│   │   └── celsius
+	│   │       └── 0
+	│   │           └── 0x00000002[pe_1] -> ../../../../../des/0x00000002
+	│   └── 2
+	│       └── celsius
+	│           └── 0
+	│               └── 0x00000003[pe_2] -> ../../../../../des/0x00000003
+	├── interconnnect
+	│   └── 0
+	│       └── hertz
+	│           └── 0
+	│               ├── 0x0000A008[A008_de] -> ../../../../../des/0x0000A008
+	│               └── 0x0000A00B[] -> ../../../../../des/0x0000A00B
+	├── mem_cntrl
+	│   └── 0
+	│      	├── bps
+	│       │   └── 0
+	│       │       └── 0x0000A00A[] -> ../../../../../des/0x0000A00A
+	│       ├── celsius
+	│      	│   └── 0
+	│       │       └── 0x0000A007[DRAM_temp] -> ../../../../../des/0x0000A007
+	│       └── joules
+	│           └── 0
+	│               └── 0x0000A002[DRAM_energy] -> ../../../../../des/0x0000A002
+	├── periph
+	│   ├── 0
+	│   │  	└── messages
+	│   │       └── 0
+	│   │           └── 0x00000016[device_16] -> ../../../../../des/0x00000016
+	│   ├── 1
+	│   │   └── messages
+	│   │       └── 0
+	│   │           └── 0x00000017[device_17] -> ../../../../../des/0x00000017
+	│   └── 2
+	│       └── messages
+	│           └── 0
+	│               └── 0x00000018[device_18] -> ../../../../../des/0x00000018
+	└── unspec
+		└── 0
+		    ├── celsius
+		    │	└── 0
+		    │       └── 0x0000A005[] -> ../../../../../des/0x0000A005
+		    ├── counts
+		    │   └── 0
+		    │       └── 0x0000A00C[] -> ../../../../../des/0x0000A00C
+		    ├── joules
+		    │   └── 0
+		    │       ├── 0x0000A000[SOC_Energy] -> ../../../../../des/0x0000A000
+		    │       └── 0x0000A001[] -> ../../../../../des/0x0000A001
+		    └── state
+			└── 0
+			    └── 0x0000A010[] -> ../../../../../des/0x0000A010
+
 Alternative Binary Interfaces - Special files
 =============================================
 
-- 
2.53.0

