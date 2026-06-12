Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6293D9DD3;
	Fri, 12 Jun 2026 22:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304018; cv=none; b=PHkfAAL4aSQs1Xc6x7kTf9srIXGgVT8VRJh432RxnmICrqMbGvnlg/Ma/fwttzZuy0z/YT9gkBbgKFFWig4e5dduzYM68AOuwnV8hWj3TO25+WL8ELcxebmuzwR63QF8a/buICZvWoe4pvw3iv9Og2DYSbbqDJThsmIwTukJreE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304018; c=relaxed/simple;
	bh=3/illUbUe14yM1bBO0POMgNIA5fhxuEisKxh0m03C50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPbjV+Dg69tZIw97gKpxHqrWNVyAmqKu+IRyFf6EV431ayVlHRPBZ2uRasMeOd8ni7FKX0Xw7yQZyaxxXbt2UYRejHTAYNR9K9e2caEoX+SOKe/p7Q/TEapZf43U44T5TX8C3al6rI6YICIGju7D5bVZeK3MdYtAxmTFVsffZtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S0ZCIAEE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S0ZCIAEE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 267703543;
	Fri, 12 Jun 2026 15:40:12 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 248CC3FB7F;
	Fri, 12 Jun 2026 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781304016; bh=3/illUbUe14yM1bBO0POMgNIA5fhxuEisKxh0m03C50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0ZCIAEEdEfSoo2+PrVYMP6AzeKkPWnpkG4y0OyewQJ+EapPUP03jYl7TDCjLd4mS
	 8E5vO559u+tXLjrZ/k64oiLgR8WBFzlz9uTFVCeZ6u/BC6Q8V/nTSpplWwyax0Lpg8
	 v2fEmWV7nxUU9sDVhhHyqjS7IqeqHGvXiS98sUbQ=
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
Subject: [PATCH v4 24/31] fs/stlmfs: Document alternative ioctl based binary interface
Date: Fri, 12 Jun 2026 23:37:54 +0100
Message-ID: <20260612223802.1337232-25-cristian.marussi@arm.com>
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

Document the additionally provided special files and their usage in the
context of the alternative binary ioctl-based interface.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 Documentation/filesystems/stlmfs.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/filesystems/stlmfs.rst b/Documentation/filesystems/stlmfs.rst
index a15da85b9971..0c7b7c006709 100644
--- a/Documentation/filesystems/stlmfs.rst
+++ b/Documentation/filesystems/stlmfs.rst
@@ -143,6 +143,7 @@ create the following directory structure::
 	|-- all_des_enable
 	|-- all_des_tstamp_enable
 	|-- available_update_intervals_ms
+	|-- control
 	|-- current_update_interval_ms
 	|-- de_implementation_version
 	|-- des/
@@ -160,6 +161,10 @@ create the following directory structure::
 	|-- tlm_enable
 	`-- version
 
+.. Note::
+	The control/ special file can be used to use the alternative
+	binary interface described in include/uapi/linux/scmi.h
+
 Each subdirectory is defined as follows.
 
 des/
@@ -220,6 +225,7 @@ values, as in::
 	scmi_tlm_0/groups/0/
 	|-- available_update_intervals_ms
 	|-- composing_des
+	|-- control
 	|-- current_update_interval_ms
 	|-- des_bulk_read
 	|-- des_single_sample_read
@@ -227,3 +233,21 @@ values, as in::
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
2.54.0

