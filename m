Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC74BF948
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894809; cv=none; b=OghJXXjnmP5d4UVm56LCzpTG0hDN8QsRHm1MVyjANGFgsffDue4yrIbDGvPIQg6lvOpJ/uI64kjCWET9mfZXjtYNuDdmVui/PQg7dP2sGkO0GAg5ACkroNosc/+y9KzOfPNCdk+3WmLdVIZQK6IMCbGKHS49/s5kdCahU3tj7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894809; c=relaxed/simple;
	bh=I4Eb0TQXvIje7w417a5e7xobqbWORtKJ3XI4af3ycUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Iu9+SgHpzu/oqZhgYIyG3dbCxyDsSbtKnWu8RvoLpmhUlBX8J8DoAo7qRSLNCN3AfCQqkY3u/eTDLlFGMg7qRY5aHHLfMxGm9htoP+LebyoJmjstw0QY4tFkRyWbUOc3rN3fl8OsPNN+dLapbNNSZmH7XoDf81puh7Dj/xBCOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0iOCn36; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0iOCn36"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8886b1d3242so979299b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 15:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790894807; x=1791499607; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0wc41/LqtlI4rj0/ni4k6LG5KAkWTAQw55eEd0Lzvs=;
        b=r0iOCn365LNLsEF9/mq7W7VNHIjuGzBXL8QKx/KpPALQPywec1KKaHHL83bp9OJTVR
         Nejeutd/FN1MjpbWZJbUGK25trdsm/DWvGE9qleZGxPw8qRgkSyG46JdEZBPNiFRaQj9
         34EEjnhxsWZyp1WWc2v2oCqQKocI+0h3yHvrN0kmUFtk5cIKeGdk+SGSoEiFif+EMkvE
         p2YCj5BdYkrbtYSUBK52dG6zlI1N6Fu8qfCWcrOhrESUaHfZHMkkEBKA6b0zdE9oivD+
         2osQWshZIbUGbBSWvqiBzu1TziHTmlWF3O/KEPmjlEg1QeJGGGF/R38dZmP0f2Lzw7ij
         DCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790894807; x=1791499607;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x0wc41/LqtlI4rj0/ni4k6LG5KAkWTAQw55eEd0Lzvs=;
        b=amSiLER6ZqoHtocobV/3sYk9wmiHhhAe3/8KKe3gNxqrY70WHuyHw+16GsbChWC4T4
         IL3GY2FTTP7Y8QNg+qt+TfrNwNIDRAIRre8GaaJ7j4zsCXqwUEW7ZWQ10NA6n15D8MQx
         SB6lOxXO/DJ8gLR6xLQOAZ55lMU5jFD8HUkccmaYTTlaJUHMl87cLmYrqbLowr0Byjce
         +ylGnqJm190AdjMzdwSU2nPvXluOicYcd2yfTy7ue8W6TOqSgCh562V5gC4/N0gKZ+a/
         D2jIo+WkpxU3dNGuwYDkO22VU1z1BU/xTuxglilkLWGETz3G7b2+H/wHyirEhnQTYn6e
         ootQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcqq97L9WCPcIYvE9BWDLqf72nu4MUjHmwaYu4z8344oIxLSwud3HmEWZD586y7ZGF/MiVO1RWs8YWuGf3@vger.kernel.org
X-Gm-Message-State: AFuF++n8dvyp6P312gVV2pDMz9iC5jOunTOWJWV/80ousm7sUuxwqJce
	DhMBDeebacPjfoRPCGN+xFhXX01BEr2LCjPmrEZYN3jVsvXA0XR1nvadZu6AkDQKrJieJEyzWh/
	26g==
X-Received: from pgbcs6.prod.google.com ([2002:a05:6a02:4186:b0:cc7:d1fb:4ccd])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a10:b0:3de:8ee8:8306
 with SMTP id adf61e73a8af0-3e0bcfdd8ecmr751775637.31.1790894806215; Thu, 01
 Oct 2026 15:46:46 -0700 (PDT)
Date: Thu,  1 Oct 2026 22:45:30 +0000
In-Reply-To: <20261001224531.765278-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001224531.765278-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001224531.765278-7-praan@google.com>
Subject: [RFC PATCH 6/7] iommufd/selftest: Add observability test for iommu-nr-pages
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

Add a test case to validate the iommu-nr-pages fdinfo metric. The test
maps sparse IOVAs to force page table directory allocations, verifies
that the metric increments accordingly, and asserts that the count
remains stranded after unmapping, verifying the current behaviour
required for future automated reclamation logic.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 tools/testing/selftests/iommu/iommufd.c | 48 +++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index d44b34b05757..f5f4ef01ea4f 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3613,4 +3613,52 @@ TEST_F(iommufd_device_pasid, pasid_attach)
 	test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 }
 
+TEST_F(iommufd_ioas, iommufd_nr_pages)
+{
+	char path[256];
+	char line[128];
+	FILE *f;
+	long nr_pages_initial = -1;
+	long nr_pages_mapped = -1;
+	long nr_pages_final = -1;
+
+	if (!self->stdev_id)
+		SKIP(return, "Needs a device attached for HWPT");
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", self->fd);
+	f = fopen(path, "r");
+	ASSERT_NE(NULL, f);
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "iommu-nr-pages:\t%ld", &nr_pages_initial) == 1)
+			break;
+	}
+	fclose(f);
+	ASSERT_GE(nr_pages_initial, 0);
+
+	/* Map a page at start and one far away */
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE, self->base_iova);
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE, self->base_iova + (1UL << 30));
+
+	f = fopen(path, "r");
+	ASSERT_NE(NULL, f);
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "iommu-nr-pages:\t%ld", &nr_pages_mapped) == 1)
+			break;
+	}
+	fclose(f);
+	ASSERT_GT(nr_pages_mapped, nr_pages_initial);
+
+	test_ioctl_ioas_unmap(self->base_iova, PAGE_SIZE);
+	test_ioctl_ioas_unmap(self->base_iova + (1UL << 30), PAGE_SIZE);
+
+	f = fopen(path, "r");
+	ASSERT_NE(NULL, f);
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "iommu-nr-pages:\t%ld", &nr_pages_final) == 1)
+			break;
+	}
+	fclose(f);
+	ASSERT_EQ(nr_pages_final, nr_pages_mapped);
+}
+
 TEST_HARNESS_MAIN
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

