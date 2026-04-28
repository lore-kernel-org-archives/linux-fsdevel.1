Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F65F2DFA3A;
	Tue, 28 Apr 2026 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341665; cv=none; b=LmHnMGfYhxt9VLYDwfeSGqlwlgcWkZa4prZnKQ1QEZ2icWTkKIF92XwALYvTXpoP/9V7FU49HYL1+52ID33d9eAsiWCFcuSioNBLr57S/wwcQUPzXelKMGM5eU4vfjejZIPNBGq8nkaGuvLr7bNEbxUWj0Dd1/2MluhsVG0iAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341665; c=relaxed/simple;
	bh=X6mi/z40zxSXPzYGHiDIYcErvECj/TReHEyGe6BtLKY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Vsxeqc7wuLXxBopiAhSvra5YOaOAuiCpnCuRA/PP7wxnBWpZGQF3lXXAcCPVDi4vDLBW4hXyDjugGzha6midmgTo4kU/3IhgipOw+CaweC8hTvph2E/DVe4vN9Bcw0+e01fwSIaerCPp3853ONNo1b8cMiXAV1ip0IcYS7hzJSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=o8lopHyP; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="o8lopHyP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1777341658; bh=JXx+eQhSmtI3VwbwtA92nRqKi+lavmKmgwnzr37qcAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o8lopHyPwN+JhIexIjy/ovwUnwsko6AZWfdD5ac5enUVPVPcb9NN2A755VNJjihbF
	 mx5MunT0Cz0EZvFYT+PrLk+jO7jxIrKfxyDVmPbEkeHjizE/s3L4rPrvVEacArKveL
	 x9487pUUPFmArhiJ3P0BuTDdi5CBIhc9qqDgPPXk=
Received: from node68.. ([166.111.236.25])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id EEC31E8E; Tue, 28 Apr 2026 09:59:44 +0800
X-QQ-mid: xmsmtpt1777341586tdqr1jlqd
Message-ID: <tencent_22E6B8849EC1141FE7773C64467E6F1E2C09@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJM3vnzFDT87lrJUZP4DrBnGP/EagY50ufGw3T2popJz76ikK1Qw
	 JmQwsjnStBYE1oayqJOEd9rR0jnBfSgcDX+4065xYKj8kBZs0J6vUcxH1GnB9i9V7K1ULvZbhL18
	 8l/LAmraXDrwEfpH3+nN7ulzRL2dFPq8t0VlS1F6RnP7M6cBMoZNVeAiO/hvvahtlWu+m8o6nHZo
	 ztL8La85/coGi+TZKcEb/BANdRgd4/gNQpSB8zAd5fqi9zzxTpnxRdJ4bqaqu/KciIhlXGmb+s7b
	 jUJVseYZ/24duoJsU0iAMtcfMSbNHv8LpIBmwqaab+gOHh3Ote5j+1HIQSw9MxRFWQGhxd0zaKBm
	 Od6PtvqedpRIp0XFB761xnU9Jsk9mpJeW+DLCPgt+8jv+XWb9PlyApYlNpgkEWBC5eay9qZB1cvm
	 bk6FDv55QZm6onRayl1/j+AppWNDsG9UM6QZiS4O0WKKZd8qCW04NAbvlEXhgz+FKoRLi1kp+GDd
	 O/PfWV5bnCom+tTlNMpXcn0/tfqj98fh7g7KCT2gTOFx4pxIy2r1/Gk3SMVmSrID6i22qN/Gl6wf
	 Yh2Pc9mwm6uig2qXJEChP9EebBJMTPjBF54/sqLEsiklqlDqnG7NB7jiqouyMhHpOSYWj3MR8fvP
	 a9Mk2HuOweT7QTuBl0Qo7bgCEAHs13IMajLyiwMRFlUNvnaPk1ReKSFkIpy0Q6GEPLqPHQO/lRtT
	 AtPx/VZIKc2R2eRsOPq9tlpjjmTtRos5yTaceWTaUuN21JK8rnj86vG3rRZrC+3BKgWPMJNvch8T
	 hI9+2tgW5iAZ3/YbRWJWopnEhQDQH1lEr6dakI0U2oeswFiWa6VGVizGu4MCxdGcppQqvcYRsAiv
	 a2ML0LeKO1nUU7QGNB2QntW/Prk7vJUMnmWX4ZbKhC1LCHO1xu/RPNSska/36IY3fX/HPAUBaCj6
	 7T36iLqaqSa5Idsmt/+D7aUrnBGAPeYijvmRzhoK4xwTwgzOKzarX9XZtAPXUcno5rQCrLmwTKPW
	 7uwUHkKcSppAprLRG+LGUP1QIXcQ8mgi6PvyVDqVaDWwD0EmBSDRBsF0s56neH8ezlMTztkYUKOE
	 1S1BRC
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: fujunjie <fujunjie1@qq.com>
To: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Haoran Zhu <zhr1502@sjtu.edu.cn>
Subject: [PATCH v3 2/2] mm/filemap: do not count FAULT_FLAG_TRIED retries as mmap hits
Date: Tue, 28 Apr 2026 01:59:44 +0000
X-OQ-MSGID: <20260428015944.2601099-2-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_AA501E9A238337BD167E5C2ACF948A1AF308@qq.com>
References: <tencent_AA501E9A238337BD167E5C2ACF948A1AF308@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A fault that starts synchronous mmap readahead can return VM_FAULT_RETRY
after dropping mmap_lock.  The retry may then map the folio brought in
by that same miss.

Do not let this retry decrement mmap_miss.  The retry still maps the
folio from the page cache; it just does not count as a useful mmap
readahead hit.

Signed-off-by: fujunjie <fujunjie1@qq.com>
---
 mm/filemap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 543e51c32397..86a46a61eac8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3933,6 +3933,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		 * we can stop read-ahead.
 		 */
 		if ((map_ret & VM_FAULT_NOPAGE) &&
+		    !(vmf->flags & FAULT_FLAG_TRIED) &&
 		    !folio_test_workingset(folio)) {
 			unsigned short mmap_miss;
 
-- 
2.34.1

