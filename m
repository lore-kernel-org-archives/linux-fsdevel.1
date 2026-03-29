Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466FE3815E8;
	Sun, 29 Mar 2026 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802064; cv=none; b=DYXQrmhOpm74VjTyDS+Ft8lscgJ3rEJLbDP/jIvkVVfc5EQleb1SOtzS0adI6FYALPSYDESF7AprzZH7OHullP9/ZkP3b8vGqORRLZQA5aizn5cy40WVuuIjZC/wedejC4I8Bms0icePaVlKocGxXQiaTJrm6+IbeD4XlBavIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802064; c=relaxed/simple;
	bh=dTqkmgt1quRevHHa0TZRui5Wp3YXi+K3Ow/haWYVuMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swu1gI1GElZLfMvvnmKaCye1L3GZEnRfgTfpaQ+KZLWcT6NPGTKtaM+YFL2J+4FV3Omyhxg3gOuwpar9bJ0nMf7h6QiayfaHwNYkKAVtZAdNdupSFMuWUqC+miXLgxfM0DREzQZ6Jcr1sxDt3s20qSOlCwx9r4G6ciPH3aam6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=td35rS6F; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="td35rS6F"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB1043627;
	Sun, 29 Mar 2026 09:34:10 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 963933F915;
	Sun, 29 Mar 2026 09:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774802056; bh=dTqkmgt1quRevHHa0TZRui5Wp3YXi+K3Ow/haWYVuMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=td35rS6FeklebgAyR/qTlU8UefhAUBXdf64Dg0ydVZTGwXt7722Zu+K6RuOlkueD6
	 qFFu2DTEv4P7FMh5xPHzC/cL/1+5BQvuANWlY3s4HWaYezdjSnQJy9VMxo3r+42bZd
	 pRAJyVwqvc5rRmfP1w41Bm/5dH2IHo1VRrfuZ0P4=
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
Subject: [PATCH v3 01/24] firmware: arm_scmi: Add new SCMIv4.0 error codes definitions
Date: Sun, 29 Mar 2026 17:33:12 +0100
Message-ID: <20260329163337.637393-2-cristian.marussi@arm.com>
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

SCMIv4.0 introduces a couple of new possible protocol error codes: add
the needed definitions and mappings to Linux error values.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 7c35c95fddba..44af2018e21d 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -45,6 +45,8 @@ enum scmi_error_codes {
 	SCMI_ERR_GENERIC = -8,	/* Generic Error */
 	SCMI_ERR_HARDWARE = -9,	/* Hardware Error */
 	SCMI_ERR_PROTOCOL = -10,/* Protocol Error */
+	SCMI_ERR_IN_USE = -11,  /* In Use Error */
+	SCMI_ERR_PARTIAL = -12, /* Partial Error */
 };
 
 static const int scmi_linux_errmap[] = {
@@ -60,6 +62,8 @@ static const int scmi_linux_errmap[] = {
 	-EIO,			/* SCMI_ERR_GENERIC */
 	-EREMOTEIO,		/* SCMI_ERR_HARDWARE */
 	-EPROTO,		/* SCMI_ERR_PROTOCOL */
+	-EPERM,			/* SCMI_ERR_IN_USE */
+	-EINVAL,		/* SCMI_ERR_PARTIAL */
 };
 
 static inline int scmi_to_linux_errno(int errno)
-- 
2.53.0

