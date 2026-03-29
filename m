Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BFC385502;
	Sun, 29 Mar 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802115; cv=none; b=uVeIJhtcoU1Y4eQnLVRyx71xA7gT7y3yikOZETlSQn3wvfqJeujiUQqciEi7EiVj8SyhPT/SdjcXXNYpaWx0qlvEBt/+Puwywbv5YFYoN4G6tGxcmts5zfQvKEx4GLp+IWrN+B/F4dOH/iB2KBH+102Q2RG+wkWZeTIdy+aQTH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802115; c=relaxed/simple;
	bh=j6MY54MyYB+zVmZUg1iZ0WGTmNxZOXrl4lkzOarnPxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKchPfH7yNqshcBdydBVhJUn9YfaljX9hhnXpQjBqO6CNQwr3/Gq+pwpCxu9uI0EwsRNQ1BQWaSFL+SWoYL95OVPtK2541o3LUOYsZVJOKH+Wu+LQhtmwRp+4zRyb5Zb/kudMxV6rbNpWohg2yrpZnjdxKUMm1IfoIifAhZ7HlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Dgnw3vzb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Dgnw3vzb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 460A13627;
	Sun, 29 Mar 2026 09:35:07 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D30A3F915;
	Sun, 29 Mar 2026 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774802113; bh=j6MY54MyYB+zVmZUg1iZ0WGTmNxZOXrl4lkzOarnPxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dgnw3vzbfQpD7QezXT0FmAppsILu5yCoTVTJCMDruHhzoKKn1BX3fqmhKIydh8x6R
	 9OB2UeTXGbyqU1ezFIxSduYJsn5FKwnH8h2tQulBccJAHOFLT7RQXkNvlHyDImRvgH
	 oIvPu0SG1hOL/JMx/U8Msi5eADdO0E9YwYvUFnnI=
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
Subject: [PATCH v3 18/24] fs/stlmfs: Document alternative ioctl based binary interface
Date: Sun, 29 Mar 2026 17:33:29 +0100
Message-ID: <20260329163337.637393-19-cristian.marussi@arm.com>
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

Document the additionally provided special files and their usage in the
context of the alternative binary ioctl-based interface.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/filesystems/stlmfs.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/filesystems/stlmfs.rst b/Documentation/filesystems/stlmfs.rst
index 2b49beb5b960..e4f07a4f930d 100644
--- a/Documentation/filesystems/stlmfs.rst
+++ b/Documentation/filesystems/stlmfs.rst
@@ -113,6 +113,7 @@ the following directory structure::
 	|-- all_des_enable
 	|-- all_des_tstamp_enable
 	|-- available_update_intervals_ms
+	|-- control
 	|-- current_update_interval_ms
 	|-- de_implementation_version
 	|-- des/
@@ -130,6 +131,10 @@ the following directory structure::
 	|-- tlm_enable
 	`-- version
 
+.. Note::
+	The control/ special file can be used to use the alternative
+	binary interface described in include/uapi/linux/scmi.h
+
 Each subdirectory is defined as follows.
 
 des/
@@ -190,6 +195,7 @@ values, as in::
 	scmi_tlm_0/groups/0/
 	|-- available_update_intervals_ms
 	|-- composing_des
+	|-- control
 	|-- current_update_interval_ms
 	|-- des_bulk_read
 	|-- des_single_sample_read
@@ -197,3 +203,21 @@ values, as in::
 	|-- intervals_discrete
 	`-- tstamp_enable
 
+Alternative Binary Interfaces - Special files
+=============================================
+
+Special files are populated across the filesystem so as to implement the support
+of more performant alternative binary interfaces that can be used instead of the
+main human readable ABI.
+
+IOCTLs Interface
+----------------
+
+The ioctl-based interface is detailed in::
+
+	include/uapi/linux/scmi.h
+
+The filesystem provides special files named *control/* to be used with the
+ioctl interface mentioned above: note that the behaviour of some of the ioctls
+is dependent on which *control/* file is used to invoke them (as detailed in the
+UAPI header above).
-- 
2.53.0

