Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775648033C
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188666; cv=none; b=sFy887BSEKj+c06whKBPqHcWChp+k6K6hxmim9EN8iQ6UMjOQZrm9LBIYHGnyXjFdrojjtXshOKTBLL7WWr8SfKpxndAgGNRRhfSJeFBrbhGil+puAudRjeJ6NKOvBJXwfvG6AVkjPwBQvO7GXCcxfeHm32zIEmqRcHG9ltxJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188666; c=relaxed/simple;
	bh=1WIhhqyimIG6xgGwMZqPr2KBtiPQ844g/owpCXhS4vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nqMdU4L8rbbSjeulOFKL7xBrKfF8YR5bDk6vBPCTf17s4mJS39QO6fL5ZzYonSa8HaIuOr6lRk345Y47sz0Vkito9F7qymIdraNljXw09/ahyUJRe1yqVHGShtWd5SYS5Gjd4o1NzjONsIDuXoqWlU+yo2y/LSyrQ6km2AoiQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL/n9Ist; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL/n9Ist"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7b41fdf9de2so20954047b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 04:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779188664; x=1779793464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9WEPJj4wYvtkwkwfLE2DQUprbinqua7axfePI1DHQ9g=;
        b=VL/n9IstAZRPyyUHAnTEsbBtI8YCY1VlmJp7SSnVhN5qARYEPvxSoebC5V4RcKenXZ
         98Z5H4mAep0KHmN0zfF4blPxBRym+XPZv+1FhqL8Y916GtlGD8FjnN9CVTgrhLuyPq+B
         SSsJ9Mu+AwMwrUalrab7dFP4Fmva6vkBtlZ9Xsxyup5I8YvXivRcLJqOkOPhiHmch3f+
         q+ftJzbC8J8cQzfp4PGteMJePrDWT0zRq4fDP+eYGREqqTPFCqNujkBAhIC1fK2sMhll
         GV8wo/Qz2dQwSh8vkVPrQP5IMW0EQ8lHBuCNjbg/ocBjJJdq6wZBIRXXs/AGgQHnAtQj
         TNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188664; x=1779793464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WEPJj4wYvtkwkwfLE2DQUprbinqua7axfePI1DHQ9g=;
        b=D8DAb75dI+MZnxskXBXR1ppW3znizoOmeJNP6L83BY0TRMV8g50eVhAF0XxjLUzVP/
         q5rpCuJZXeeKwP486RCUpSCMFPopLYCLX31MQF1lyx0IRGUchfV2K8BZnqO9yrdN3Ac2
         UKoEtYCXmPVS38ApfL34Fv3RswGUrQWAATA1PTVONQjU5wExUbow7KdgnOUtHh9qXZ8i
         bjtqcL1Bt0gpyCVlKZd+97hLF86se6kCZpm68eC6NFp5JrIZdSKepu/dyhQZzqBHtb4F
         dlIOeEdSRi2x5mgOzehSk9cIE0frDUxU65d3yhv2rOCCRZ4niQkavEgqrUyaG3Qc177b
         wFwA==
X-Forwarded-Encrypted: i=1; AFNElJ8k44kj2IUAPR8hqFhXahS1s6e6lH36Y1LSd1Im8m67UmFDUyiGFu32gGR8XHZ7bEuT50WPfhJxDkaKmQ4g@vger.kernel.org
X-Gm-Message-State: AOJu0YxMutxhKnMi/Yq4VRzQZpJD5/7YyNg8xedhhgj9f2T6bJu5ci9r
	ML5AGo8wRYcSZZW36/v4mreO2Anc/6yey5XTuFllR54e4rZLdELKSYin
X-Gm-Gg: Acq92OECo5A4ozwSf0TnDlFZ4+sh+1Fy3nn6JCIX9stoiqjS1mV0UE4IDptXHIDw+qH
	MPs6BROL/fPdyqhdr3qK+fiDvgxuyqKx0jlhU3jw2i7+HoT6Dn9M2gBn+7BYkKcy0AACgFVyxxf
	piBy9udPEqTxeJsXsUQThcdPpGPobB8KJFGi56kkf3jlLA2YdNI1w9GtMXUT1+X1fjjoFW4sVs0
	qdT/9HL7bjmlDH1xrbDUo7whqdavIea5IhgVTMQZgBJtyPbqishyli4j6KVsjG0d377JWqXEDCC
	FVWawzYiJexWwqtiXNNF4M028ZQqmQ3EJWszhAoH/pJhzkFC1m5fCKm7twT/ia8kEKS3E3CLHP7
	vsqjJ2GQMZoskzVYAECEtegXWApjslahnkr53g7SZzoymSTLYR31vpiYA8ALnd9Gc7OJG5FeeRe
	pqAuWT6aRwWihuQ2+OZIdiazndey9FptGMitto3Q7O0qUI1na8fwoWSaweEI2jirrN+/17sQV49
	H/VTBLg0bibgq7QSSl+0Pjyk7X9UpY=
X-Received: by 2002:a05:690c:c1a:b0:7ba:fdc5:17a3 with SMTP id 00721157ae682-7c95c6f978fmr196298607b3.43.1779188663775;
        Tue, 19 May 2026 04:04:23 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0ccf7sm35206827b3.25.2026.05.19.04.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:04:23 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>
Cc: ZhengYuan Huang <gality369@gmail.com>,
	ocfs2-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ocfs2: harden inode validators against forged metadata
Date: Tue, 19 May 2026 07:04:01 -0400
Message-ID: <20260519110404.1803902-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This series adds three structural checks to OCFS2 dinode validation so
malformed on-disk fields are rejected before ocfs2_populate_inode()
copies them into the in-core inode.

The checks cover:

  - i_mode values whose type bits do not name a canonical POSIX file
    type;
  - non-device dinodes whose id1.dev1.i_rdev field is non-zero; and
  - non-inline dinodes that claim non-zero i_size while i_clusters is
    zero, covering directories unconditionally and regular files on
    non-sparse volumes.

The normal read path reports these through ocfs2_error(), matching the
existing suballoc-slot, inline-data, chain-list, and refcount checks.
The online filecheck path uses the same structural predicates but keeps
its own reporting contract, returning OCFS2_FILECHECK_ERR_INVALIDINO
instead of calling ocfs2_error().

Validation from v1 still applies to the unchanged reachability model.

---

Changes in v2:

  - Patch 1 drops the tautological S_IFMT|07777 mask check and reuses
    fs_umode_to_ftype() for the canonical file-type predicate.
  - Patch 1 mirrors the i_mode check in the online filecheck path.
  - Patch 2 factors the i_rdev cross-check into a shared predicate.
  - Patch 2 mirrors the i_rdev check in the online filecheck path.
  - Patch 3 factors the size/cluster invariant into a shared predicate.
  - Patch 3 extends the zero-cluster rejection to non-inline
    directories, while preserving the sparse regular-file carveout.
  - Patch 3 mirrors the size/cluster check in the online filecheck path.
  - Patches 1 and 3 add Link trailers to the Sashiko review Andrew
    pointed out.

Testing after v2:

  - Replayed all three patches onto the original base, checked with
    checkpatch --strict, and applied cleanly with git am.
  - Rebuilt a fresh bzImage from the v2-applied tree.
  - Booted that v2 kernel five times under QEMU: sparse regular-file
    regression, non-sparse no-forge regression, forged non-canonical
    i_mode, forged non-device i_rdev, and forged non-zero i_size with
    zero i_clusters.
  - The three forged dinodes were rejected by
    ocfs2_validate_inode_block(); the two unforged regression cases
    completed without validator errors.

Michael Bommarito (3):
  ocfs2: reject dinodes with non-canonical i_mode type
  ocfs2: reject dinodes whose i_rdev disagrees with the file type
  ocfs2: reject non-inline dinodes with i_size and zero i_clusters

 fs/ocfs2/inode.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 2 deletions(-)

-- 
2.53.0
