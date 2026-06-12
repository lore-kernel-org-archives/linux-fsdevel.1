Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DF63EFFC8;
	Fri, 12 Jun 2026 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304027; cv=none; b=ShZQZlwPnzqwzcCbR0Pv0TqgpQWlilQdBGpFTqvOqVP/GyC4ORSDk1ARB+d+aep/pjdWqmunGN0q5v14hspKOc1jwysvzWKbl/q/nJ1g4cQymcGtPYqtg4Vg3vBUvAVsLxVEzFT8XjFhxq7UD7Gu5iHls5JjR/so69WJhy6XYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304027; c=relaxed/simple;
	bh=LqAFIQOzWsZZ1f4YVWDCPJKEayziLPMgzmXHTS+j+d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJU0JmJdVMdhsNwQXcxMuAVbCsgNZMHiSwePUNjoYaFdzR+mD+7MKjXoZ1ICoGzwogREjH0ObI7PN1YKjbGE6QdPj0mmeV06pfyaIH/4ZKtl+T8syg0vIMKUmg38opFiX0BhT3RKWdu26gdIPnN5raZ55yCyrabP2U8Asae76qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fkDoszFJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fkDoszFJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97CF93543;
	Fri, 12 Jun 2026 15:40:20 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A4113FB7F;
	Fri, 12 Jun 2026 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781304025; bh=LqAFIQOzWsZZ1f4YVWDCPJKEayziLPMgzmXHTS+j+d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fkDoszFJVKpPXpqXNuYv5hHk5klDSDyF56xK0IYU8HwlApf3usktjn7YO46T6RwRl
	 uVE8wC8Z5HxlDSmUX+BFsHY+DjAJcCrFTnBPOKOS7p2Mv7HRiroSEPe0JMnxMGScx1
	 9iDTvps/llxzysFrrMJEzC07b/5noKIurxvSaLxs=
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
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 26/31] fs/stlmfs: Document alternative topological view
Date: Fri, 12 Jun 2026 23:37:56 +0100
Message-ID: <20260612223802.1337232-27-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612223802.1337232-1-cristian.marussi@arm.com>
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
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
v3 --> v4
 - renamed to by-components
v2 --> v3
 - completed FS tree description
 - renamed components to by_components
---
 Documentation/filesystems/stlmfs.rst | 72 ++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/filesystems/stlmfs.rst b/Documentation/filesystems/stlmfs.rst
index 0c7b7c006709..b5b3cd649775 100644
--- a/Documentation/filesystems/stlmfs.rst
+++ b/Documentation/filesystems/stlmfs.rst
@@ -143,6 +143,7 @@ create the following directory structure::
 	|-- all_des_enable
 	|-- all_des_tstamp_enable
 	|-- available_update_intervals_ms
+	|-- by-components/
 	|-- control
 	|-- current_update_interval_ms
 	|-- de_implementation_version
@@ -233,6 +234,77 @@ values, as in::
 	|-- intervals_discrete
 	`-- tstamp_enable
 
+by-components/
+-----------
+
+An alternative topological view of the des/ directory based on the topology
+relationship information described in des/ ::
+
+	by-components/
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
2.54.0

