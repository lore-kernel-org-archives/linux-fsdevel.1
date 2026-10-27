Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116047;
	b=fJNYUH6z5sJgGPV8PW2ouxmTffIupBRt50aDp/JvSQTQEJqPTk260EpO1lsbyD11aGDi
	 ChMbk7MeOCd7vngdtCcbL62z06L+zgc/2E+oR5FP1MKy7HybomllA9uYbCTWbqNCx+hhO
	 1cgovaKeHz12NQw/Yp4ttNxK9fbqTO74aprZcfK6mEptt+l5hZqkzszbJLPV0koDL4fz6
	 aybu/JCw7uNWlvZC0pGS6OyjTXpz4OBWoQUWHQaf/tbLkut/8IiTOdBa8C09n+8RzLWfT
	 7lFdmu713fCdABQdsF/zmzK7Vi23nWcbcgZm3Vh50U+a/oeXEMAXRP41k3Hzx21B/Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d2ojhVyA7G70YSFxIWDEXLUjmLV19PosvKcY5O6DkLk=;
	b=HGxuEOpAO52cJQZeK5Gk6tUCVPa1aC/zyEb5C5qPccdxma8Boc9TibES2V//FoUVGmnH
	 cgZuTbks3WNGB5If4NIhDW/e/O3LF5uCyIObTBMqeupcz7vMwEcwUMk5UmaygcHMl7cP+
	 KJ9i/F8M8tombUxyPaNnpCuiiV3jCv+4iqiBywm206xFVmtiBE9GN9VtEebVYhRJYkFFN
	 XOp6IaQv/6xJQmdey//krfnYLUkLTcgTKzyw6CpxWg7jcksPAlu9ICg3Du7Z13DAoWsgR
	 PrvFPRiQJ3onIGn2v/wqEMWBt7Du6xl7AcaM05Ql9WmljZhzA1ZBIUue0i+xin7+0NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VwS1GD2u;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335E60A263C
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 15:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D335E60A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VwS1GD2u
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e46e449e8so1825935f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116045; x=1793720845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d2ojhVyA7G70YSFxIWDEXLUjmLV19PosvKcY5O6DkLk=;
        b=VwS1GD2uQIUAtVynptslNi32b8hDtW5hYaCUcKM7l7bDk8D2wwG0nN1Dd+qJlkwsd6
         MmVp8/dTgoB8uCoVh3luf4fXvzBIBvjHJtruTyc3TY1ZFSvlGD9NMJXS8VYD2ODxvcGe
         mYRxn75gVzpHewYITJkVaQBjRO8juzFR0MJL9cbnVL0f9JqNqCVHiZD1OrlIdwJbbxRa
         pbzfPAi2Ig0HsjJ9BerceMg9ZQDbn6GujqiuOVumpmTvpfh6Yg6TDdTLav4cqQ4WF2/x
         Dk5YE+esLyF8KIMN7snbZwHrz+XiLaHbVgDc6kXG6wmkyTzr2v0k+6QHcK1zfNOk/hz9
         yQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116045; x=1793720845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d2ojhVyA7G70YSFxIWDEXLUjmLV19PosvKcY5O6DkLk=;
        b=haGzzopyKMULdmUsfgFElORg3ugPUja+IZWf1okkM5q8TNRJAtwdA45lAKAi9zgKjL
         te2yk3GBpH6SU8T4jO+aH8jhPqGlbpIayoLy9ieopzfJCFVSxMKQP7hd2nyPUzbLR1Vj
         9iQUTNk6YDO9AnwgTd6lt/4WhO8bYmI/+8AZYfbhVj1RjR5N9LqKyO0GcuESstcTmDI2
         JctO0iKzQblc6AaELRoincQcHlf485nkzEZkGH8BJ5K8/swLtaOvF5Y+Lro4T0sxr+4M
         RClavMXUz6R0XqaBOV26DGhdd8Rr4bbm5znHXgqu7aE6oAFsEcXyfGmMzZAmwn3qngqg
         uFiA==
X-Forwarded-Encrypted: i=1; AKwUvBxbsAqgaUHIGPKxg6U9vOHD843UU+GQGRj6x3VY2NWJKVHNYQBv2Gt+lIZMr60yla2Nb382SeLSA3nriXuZ@vger.kernel.org
X-Gm-Message-State: AFq9FYJIbUwwJWHH3XVmGMTg8XvCY2YNFA5318jbp3Q44BNkBJ3fZX8T
	JpkbUeCLnX+vuHWPqqeshHnrHGPnewSSlB27Uhni0iRrzFVBcPfO0hxn
X-Gm-Gg: AYBFou30EtjRYDyJZTCJAAdytY58M+tbomt0gk4bVH834wwBK0xBfQanHTG67DuSFIT
	K+J29n5CXVglaHwvjA5l8q6dlLyd+hP7ftQ8A7KjoMeBereoViOf7vL35ule+k12B4Q9CIfKdK0
	SthAVQiKBDHelFkbAMCjjG/XsdKHVc9uP+fOwHAG6ZuwQuzTGQ6V5wZlw6g84z0qt5DKQ90xLLz
	txHtUWii9KhrSMiYicShFE3ScyJADeEUTG5r2u5B2buJ4zhDMOxYkt+r73pmM/LLFJAmGZTASJE
	goqVHS59GDv0XbIGYXYxnkVxmdNG9HCMK7d1NNURnZb7g1h5Aaz/Aifyyv1sI90sGiU/z162gRS
	58dY/FWk1ovZgcFY3FijkbawVx9pz+OpVc6dPZPOMDFKctkWFPrR/swzrkgopvLWNjncaA5ucbZ
	BnlZlgNFqixqjScUumU/IyNp1jqBsC8z54zMtwK//a7p0olDhCoB5aP1a+o1ZAKjsQSs7BkSbat
	vfjtDoxDwRIzIdd92aavdLa69NVD4uT8d9R9WFq6aidnCmznR31Sf1IgzcR2dOvcLzHiCIBsi7S
	qjUzwm8s5mWw7xru7r3Q7Ab7NnKF8yWxZhhB2y/li4Jqv2yTFc2rKQj2FfSnEf9f6MwYJeq0pB9
	dOzO4zGYfWPg0CbrzT5hYDiEgUB4Wuicm3ZOUqT3LGkWB5XV39XPDec3f3LNbgBggRg==
X-Received: by 2002:adf:f284:0:b0:48e:2980:d396 with SMTP id ffacd0b85a97d-48e3eb8d6a5mr16586892f8f.37.1793116044977;
        Tue, 27 Oct 2026 08:47:24 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.47.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:47:24 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alexander Graf <graf@amazon.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Kardashevskiy <aik@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Connor Williamson <connordw@amazon.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Erdem Aktas <erdemaktas@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Gregory Price <gourry@gourry.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	James Houghton <jthoughton@google.com>,
	Jan Kara <jack@suse.cz>,
	Jianxiong Gao <jxgao@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Joey Gouly <joey.gouly@arm.com>,
	John Starks <John.Starks@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Oliver Upton <oupton@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tycho Andersen <tycho@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	x86@kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: [RFC PATCH 13/14] samples/kvm: Back absent pages on demand in the sample provider
Date: Tue, 27 Oct 2026 15:46:48 +0000
Message-ID: <20261027154649.91571-14-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027154649.91571-1-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

The sample provider fails get_pfn() for an absent page and keeps its
frames on a punch hole, so tests cannot exercise a provider that backs
a hole when it is asked for a frame, one that backs more than the page
asked for, or one that frees the frames that a punch hole gives back.

Add MPS_NEW_FILE_FILL: get_pfn() then backs an absent page with the
whole 2 MiB block around it, and put_pfn_range() makes the pages absent
again.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 samples/kvm/mem_provider_sample.c | 29 ++++++++++++++++++++++++-----
 samples/kvm/mem_provider_sample.h |  9 ++++++++-
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/samples/kvm/mem_provider_sample.c b/samples/kvm/mem_provider_sample.c
index 670e36207e59..41e0ce5b6bc6 100644
--- a/samples/kvm/mem_provider_sample.c
+++ b/samples/kvm/mem_provider_sample.c
@@ -41,6 +41,7 @@ struct mps_info {
 
 	unsigned long *absent;		/* taken away by MPS_SET_PRESENT */
 	unsigned long *readonly;	/* set by MPS_SET_READONLY */
+	bool fill;			/* MPS_NEW_FILE_FILL */
 
 	struct inode *gmem_inode;
 };
@@ -62,8 +63,15 @@ static void mps_gmem_put_pfn_range(void *provider, pgoff_t index,
 				   size_t nr_pages)
 {
 	struct file *resource_file = provider;
+	struct mps_info *info = resource_file->private_data;
+	size_t i;
 
-	mps_zero_range(resource_file->private_data, index, nr_pages);
+	mps_zero_range(info, index, nr_pages);
+	if (!info->fill || index >= info->npages)
+		return;
+	/* Lockless, like get_pfn(): guest_memfd holds its invalidate lock. */
+	for (i = index; i < min_t(size_t, index + nr_pages, info->npages); i++)
+		set_bit(i, info->absent);
 }
 
 /* Byte range [offset, offset + len) of @info as page indices. */
@@ -228,7 +236,9 @@ static bool mps_bits_are(unsigned long *bitmap, unsigned long first,
 /*
  * The frame behind @index, and the largest aligned block around it that is
  * present and has the same attributes: the file's frames are contiguous.
- * Lockless: a change is followed by kvm_gmem_revoke() or kvm_gmem_restore().
+ * Lockless: a change is followed by kvm_gmem_revoke() or kvm_gmem_restore(),
+ * except a fill, which only gives frames to holes; guest_memfd tells its users
+ * about the block.
  */
 static int mps_gmem_get_pfn(void *provider, pgoff_t index, unsigned long *pfn,
 			    int *max_order, u32 *attrs)
@@ -241,8 +251,16 @@ static int mps_gmem_get_pfn(void *provider, pgoff_t index, unsigned long *pfn,
 	if (index >= info->npages)
 		return -EINVAL;
 
-	if (test_bit(index, info->absent))
-		return -EFAULT;
+	if (test_bit(index, info->absent)) {
+		unsigned long first = ALIGN_DOWN(index, PTRS_PER_PMD);
+		unsigned long i;
+
+		if (!info->fill)
+			return -EFAULT;
+		/* Absent pages are zeroed already. */
+		for (i = first; i < min(first + PTRS_PER_PMD, info->npages); i++)
+			clear_bit(i, info->absent);
+	}
 
 	ro = test_bit(index, info->readonly);
 	*pfn = info->base_pfn + index;
@@ -307,7 +325,7 @@ static long mps_ctl_new_file(void __user *uarg)
 
 	if (copy_from_user(&nf, uarg, sizeof(nf)))
 		return -EFAULT;
-	if (nf.flags || nf.pad)
+	if ((nf.flags & ~MPS_NEW_FILE_FILL) || nf.pad)
 		return -EINVAL;
 	if (!nf.size || !PAGE_ALIGNED(nf.size))
 		return -EINVAL;
@@ -337,6 +355,7 @@ static long mps_ctl_new_file(void __user *uarg)
 	info->cma_pages = pages;
 	info->base_pfn = page_to_pfn(pages);
 	info->npages = npages;
+	info->fill = nf.flags & MPS_NEW_FILE_FILL;
 	mutex_init(&info->lock);
 
 	fd = get_unused_fd_flags(O_CLOEXEC);
diff --git a/samples/kvm/mem_provider_sample.h b/samples/kvm/mem_provider_sample.h
index 57f494dc46fa..45ec9605b593 100644
--- a/samples/kvm/mem_provider_sample.h
+++ b/samples/kvm/mem_provider_sample.h
@@ -19,11 +19,18 @@
  * Returns the provider fd.
  */
 struct mps_new_file {
-	__u32 flags;	/* Reserved, must be 0 */
+	__u32 flags;	/* MPS_NEW_FILE_* */
 	__u32 pad;
 	__u64 size;	/* bytes, page aligned */
 };
 
+/*
+ * get_pfn() backs an absent page, with every page of the 2 MiB block around
+ * it, instead of failing, and put_pfn_range() takes the pages back: a
+ * provider that allocates on demand and frees on a punch hole, for tests.
+ */
+#define MPS_NEW_FILE_FILL	(1U << 0)
+
 #define MPS_NEW_FILE \
 	_IOW(MPS_IOCTL_BASE, 5, struct mps_new_file)
 
-- 
2.47.3

