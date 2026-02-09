Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D535337FF46;
	Mon,  9 Feb 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651346; cv=none; b=k5KnNWuADgAK3vuyO1gH7S0uc4j8fjR32akUcXGnIy1OeI0XCcUuWx1QGJXbWwbamIK/BtKEXF/b+jRqzPh/ZoiLbHPH/GLjcQ2Mz5CRjN7u5JpYgLvh8mH/R102XCWzq5WhFprDiF0bRZ20ZdqwUnWTKLiiDTWyeWIcd/6GOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651346; c=relaxed/simple;
	bh=FFXCc43I3tk/mxj/aCNjnGC7RY/QzOM1guMiQf3LESk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdBX3+WvqnruFm2TIr4d8FSw+Y3qB0EwbVMgDaIt3ZLZCZ5n0zY12sNP1M6VHPxS4F7t+So+v2rP+suoVb/De7aGHOLofYRq1abLEVoMcLdP7bHCFQIP1EdxafeK+TTq2DtkVHH1UNdDN0T5vT9lBrkwTbze65TsYlq33aBBHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=E/Wo6n2J; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="E/Wo6n2J"
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 22225241;
	Mon,  9 Feb 2026 15:33:37 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=E/Wo6n2J;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 069652120;
	Mon,  9 Feb 2026 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1770651339;
	bh=CYd5rcNnOaKSh23TI/e5OE/xbQ5AsdzUoPUlc04ix/w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=E/Wo6n2JOKxiq9h38I1IvuqmOoawuem7eR6bOl8pkjitNGPePBxd1wZ0+Qdx1cMKN
	 VaSDoy+0j6aPxgeQo/zfKnUQWuCEYuaQeL3Fg/8PL8kYAPEzEV36QvzBgPt1LhNTj4
	 C+haQ/a5R7Fvsj/F55StLwaitXJ/2nJgPcb+SFsE=
Received: from localhost.localdomain (172.30.20.159) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 9 Feb 2026 18:35:37 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, kernel test
 robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] (resend: correct threading) fs/ntfs3: avoid calling run_get_entry() when run == NULL in ntfs_read_run_nb_ra()
Date: Mon, 9 Feb 2026 16:35:25 +0100
Message-ID: <20260209153525.9979-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aYXvc_N3LzX3Ef7Q@stanley.mountain>
References: <aYXvc_N3LzX3Ef7Q@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

When ntfs_read_run_nb_ra() is invoked with run == NULL the code later
assumes run is valid and may call run_get_entry(NULL, ...), and also
uses clen/idx without initializing them. Smatch reported uninitialized
variable warnings and this can lead to undefined behaviour. This patch
fixes it.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202512230646.v5hrYXL0-lkp@intel.com/
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/fsntfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index e9c39c62aea4..2ef500f1a9fa 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1256,6 +1256,12 @@ int ntfs_read_run_nb_ra(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 
 		} while (len32);
 
+		if (!run) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		/* Get next fragment to read. */
 		vcn_next = vcn + clen;
 		if (!run_get_entry(run, ++idx, &vcn, &lcn, &clen) ||
 		    vcn != vcn_next) {
-- 
2.43.0

