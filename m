Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D7048642A
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894806; cv=none; b=qOoiXGWHUiwMR2+oCR7OU3plIztWKhDM9baPx0Bfo+7WNzF0MxGaMImQN2X7pLVOLsMcvuk5gHLFskyNJCZyEc2VNVcfgRIxSYIj8haxmqktuhAQfABGZaAYB3lYHEy/LxAqvxcpmvAxyJ65KsTLLE1VcUAjzVM5Nez5XQnrPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894806; c=relaxed/simple;
	bh=MHNDsu3yQbllRoUb8NzvwGkLU3dDlWNg06MHok4gmaw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l5Av3THxz7jBnSJuly96XhulkWyWaif4+HPhMd2etM447wuxg3peQs3HRe+iD2RIBfGQUflWR2MDAPtxr/dUJCeadTgfJ5XVeJCAqerMFvV+UsYu3jbZPnIWP99EtXmF0GL1K3HvM4tuwHbziZ0ymxcouTKMGm7iqTPoaRGYOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qj2QzxCv; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qj2QzxCv"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso10944028a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 15:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790894804; x=1791499604; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yFPVDvuO1NNrX9ksocas+3JOEOZdDhafmgmm3nX6/R4=;
        b=qj2QzxCvAoCmH/iIJqTJ9pMVvosBXSkpOdApHifFeJJu/hKhI/0UdXfOyC8g8wK0rr
         80xsCCCkDojWcGN5+yR8Zd8NZvLVXTaPADxKKl6r16A35wYgnizcioaPSO9u0HvJ1BHs
         q+aGw2dBs4OqE0k8tOlKHJcBxUE3BgpOfUuCpf05acZ8P13d4MKMmNFoHa2m28S2qoLd
         aAd06kZIkv/gxZIGoAw36R6YF/kT/Wo7nGO8oYCgXqb939cifb0WRRBVww0MpALJIMvk
         A0T4HF+ITuD6ikxPO30Ps+xdIreR1DZWTuDs/H0fReKz432FFWu2f9G9KZyiyAEdwWGW
         LAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790894804; x=1791499604;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yFPVDvuO1NNrX9ksocas+3JOEOZdDhafmgmm3nX6/R4=;
        b=cPtA/11j33beJ3Shd+ApMroXIZ39t4CIZqhEPrnrKWjexu8V+2DtBjxi7ldWFbJyhY
         6n2lMbOb/qGeu1pex0m67pZ75yzm3WT0jzJROQtL+qEmeh7M1uolteDowiw1OqweEZZD
         psBMMj5ncKob7YUtGqw4pWuqZjeNRTFxX1ZNqKC743V7H3cUUxWpm+26U0QyxIQ1RkhJ
         Y3MJRkBysLZR7UlBtuxe6MikA5y2lzcIe6m6AlCUe4mwmlf71ZJI5QKHcswD9rgj2hBC
         4wJckO3miMVyI6J7MvNA7lRz987KRtA+FQckEXSXnLRc7nzuk35aVGYn3tYyeI2u4Cc1
         zUtw==
X-Forwarded-Encrypted: i=1; AKwUvBwj7eQGZoB/BmKmIcfQoUomBgTQoX6g4+6X8OCx4Ln8p08WdrLz7sOtxhxKBMkApKsDYPgK8x/tW68csZ+x@vger.kernel.org
X-Gm-Message-State: AFuF++lOK1njEZOH57FkMCSfF949hPcn20+X2dFTomYDx/kXqQpBu/9a
	iPrga2PK+AJIcsGnd1/sv3LjJj/sip3M7Lex1ds6aeef/Z/4zX92OAcFadt4x/WqDYnTAuObf97
	ogw==
X-Received: from pgbcv10.prod.google.com ([2002:a05:6a02:420a:b0:cc7:c2c8:8591])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1016:b0:3da:1fc0:fb07
 with SMTP id adf61e73a8af0-3e0bc9ebe3bmr821714637.6.1790894803696; Thu, 01
 Oct 2026 15:46:43 -0700 (PDT)
Date: Thu,  1 Oct 2026 22:45:29 +0000
In-Reply-To: <20261001224531.765278-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001224531.765278-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001224531.765278-6-praan@google.com>
Subject: [RFC PATCH 5/7] iommufd: Expose IO page table usage via fdinfo
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Logan Odell <loganodell@google.com>, Pranjal Shrivastava <praan@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Collect the IO page table usage statistics from each paging HWPT object
within an iommufd context and expose that data to userspace via the new
iommu-nr-pages field in fdinfo.

Implement a show_fdinfo hook for iommufd_fops that iterates over the
context's object xarray, identifies paging HWPTs, and aggregates their
nr_pages counters. Nested HWPTs are skipped as their stage-1 page tables
are owned by userspace.

Only domains whose page table is implemented by the generic_pt library
account their page table memory. If the domain of any paging HWPT does
not, the field is omitted instead of reporting a partial count.

Document the new field in Documentation/filesystems/proc.rst.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 Documentation/filesystems/proc.rst | 17 +++++++++++++
 drivers/iommu/iommufd/main.c       | 38 ++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2d06c9930fcf..90ba32e9e3b1 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2217,6 +2217,23 @@ IOMMU backend is set, or when any attached domain does not account its IO page
 table memory. Currently only domains using the generic_pt page table library
 account their IO page table memory.
 
+IOMMUFD files
+~~~~~~~~~~~~~
+
+::
+
+	pos:	0
+	flags:	02000002
+	mnt_id:	17
+	ino:	1104
+	iommu-nr-pages:	11
+
+where 'iommu-nr-pages' is the number of pages of memory used by the IO page
+tables of all paging HW pagetables owned by the iommufd context. Nested HW
+pagetables are not included since their page tables are owned by userspace.
+The field is omitted when any paging HW pagetable does not account its IO page
+table memory.
+
 3.9	/proc/<pid>/map_files - Information about memory mapped files
 ---------------------------------------------------------------------
 This directory contains symbolic links which represent memory mapped files
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 9a921b153162..51d0d100dc91 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -11,6 +11,7 @@
 #include <linux/bug.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/seq_file.h>
 #include <linux/iommufd.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
@@ -633,12 +634,49 @@ static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
 	return rc;
 }
 
+#ifdef CONFIG_PROC_FS
+static void iommufd_fops_show_fdinfo(struct seq_file *m, struct file *filep)
+{
+	struct iommufd_ctx *ictx = filep->private_data;
+	struct iommufd_object *obj;
+	unsigned long nr_pages = 0;
+	bool supported = true;
+	unsigned long index;
+
+	xa_lock(&ictx->objects);
+	xa_for_each(&ictx->objects, index, obj) {
+		struct iommufd_hw_pagetable *hwpt;
+
+		/* Nested stage-1 page tables are owned by the guest */
+		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
+			continue;
+
+		hwpt = container_of(obj, struct iommufd_hw_pagetable, obj);
+		if (!hwpt->domain)
+			continue;
+		/* Only generic_pt page tables account their pages */
+		if (!hwpt->domain->is_iommupt) {
+			supported = false;
+			break;
+		}
+		nr_pages += atomic_long_read(&hwpt->domain->nr_pages);
+	}
+	xa_unlock(&ictx->objects);
+
+	if (supported)
+		seq_printf(m, "iommu-nr-pages:\t%lu\n", nr_pages);
+}
+#endif
+
 static const struct file_operations iommufd_fops = {
 	.owner = THIS_MODULE,
 	.open = iommufd_fops_open,
 	.release = iommufd_fops_release,
 	.unlocked_ioctl = iommufd_fops_ioctl,
 	.mmap = iommufd_fops_mmap,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = iommufd_fops_show_fdinfo,
+#endif
 };
 
 /**
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

