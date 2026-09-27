Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69D3B1EFC
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790532398; cv=none; b=YCaSK3yUkmgdx41zKQ3iJo5za+nhrEXXDMXZg9GvWiKUSxbNB0+VX6gQ56ynxVKWB/iZP0zj7/kxrVOS9R2bNu1CoqyFc6Ac3hFPeDw32epQszenaS5kaLlnuRrZvvK0e21o4eayzta178Co78DJqwNXPWpI4FzPFfkQ2QhI8Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790532398; c=relaxed/simple;
	bh=Xpcikl8sIKFn87EfW0CcMDwz7ssIH+kvLFmMk6RHr1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVTZqa3g0MPwTsd5nQRwMWwnmGu73iqwJaWZxASyN4SyaXXiYcLBWfKl5jRuWtnNO5w2uz9W4JaL8rFH3y24jvL+Y7UOW00Rlac72o45aNAX38TTu+VNU2CVffjKnNJRPkmvDVbXNFZdnlLg9uSEVQ3zVRF70I0tPTJbKIzGLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxT8Z6Lm; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxT8Z6Lm"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-398b9f722abso1411041a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 11:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790532397; x=1791137197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hrm+Ev4VQJgRD6C6jxGrjXc6kFhErDTiXeP9w+0nxiQ=;
        b=QxT8Z6LmiozIzaJW5hJ3mVDFgHhrV+sPtIbAuxvMKDbXO98oSqmIZsuRPi1SfOSXuE
         MkjIbYpm9H0EqEkmvIF5lzXUfDY75+oy14oqmphLt6UFfCLKDutrr1BDj0PufD5fjSeC
         oBLB77wOSNuzExnxcUm2HCXf7t/sQpjQ7lC4A2ngp6ITVaYnFn9UFsohRPA6d5QbJn6f
         f6OX6sAMfg8cPqQxdmgmZAd1MXeGwaKAev1/0XyqmznrtwRfT5FRgm1R1eqr9eh5lrBP
         IVC1CSyCiX+SUxWHQ/Ps0XragpmiVbF96dOv3uXRypwIvMvbISp9OCjAgs/w6C5yd0G7
         /ufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790532397; x=1791137197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hrm+Ev4VQJgRD6C6jxGrjXc6kFhErDTiXeP9w+0nxiQ=;
        b=SFqzseLPl0IMh6qNAaLq1suM17lpvsbJj62nX2Kejd7vCVf2nYkVE2+0XEEE7TjPoK
         Yj5LvdLFDaDxvdDGB174Cc8y/JyZidwPA9KGN9V2ULmEXwZ0ByIYbppl494Eezg9ADST
         btYTlhc7Yf4RBzAwQ1D81dz2BWdbn+1AQGqnkorM3yr+MG0oyGBQGVMZWq9rRyvyRNoh
         cs7GUPkkDXck1XfdrArYuHUz38h+V8GQ92AJ6Vzb1VbdssXPmABQ/hlXBnixZKGvY1+J
         xB807esi+0Ox45Tx4OfzFyEAxgpifjZI6+93spSPBlzBfO5lgJGG3ryMkatyOFyh1E7t
         3ZQg==
X-Forwarded-Encrypted: i=1; AKwUvBwXhc0vvIt/Y3AeDZpZ9b2no+bfJlixnVKXp8cG2cOYWZ0w9dZyMfILBqWFE63xormQmE2sj2+aNG7usVn9@vger.kernel.org
X-Gm-Message-State: AFq9FYJRiKRhd8E7lW4lvRqlkliYUvVPK1IUxvAlse9r9aNLlCdSrTrt
	qMBXSNXBaH98J5eUFGf+S6H1juAV2WESTic+1HsLp4XUihPxrV5A7oKM
X-Gm-Gg: AYBFou0YfyOyjXEz3cPPBSV3ZgioQ/tsHOBhXdNPTfW2T47QIM0CXaHbm0NnnPa1jwi
	174s/Zvv65AfYeKkBVcaHztkMoFbpsOsfQmbU4C2b4pykwfwjEkJN+V1+VbFZADpRqVx3euDBsV
	37t59D4ubGbFJEBwMkHeYQRKcidcBwnN/gnaYv2jXosdgrP7Qw2OmndgXRtB0S2oJEZy12/LohQ
	s502Fv9b2rc3g4L5nR6QUMr/nVbB0t75bxNhYM7Y5L17ni4+lMMdn4sPKHBA1ApCluYXFNLihYj
	96zoCA04YNGuJPRA9jmFnG8vTfTC7EnguUEW3QZ48lkkR/P4i8/GkJmVVe3k3ASPFsJa+O10GvU
	l76OjTzmnvlDFoZG0pltAqnDg7bM1aP2WtNFbQvdbLhnwq5QR2rQElJPtOZoe0uHFRGR7BvwxbD
	ZpbuDynRCW+vzB5A71X5gj1AWfakZEwMlzCLRsClCNEKw+Ww==
X-Received: by 2002:a17:90b:2fc4:b0:39e:6c6a:4b64 with SMTP id 98e67ed59e1d1-3a098dfb087mr8670029a91.46.1790532396580;
        Sun, 27 Sep 2026 11:06:36 -0700 (PDT)
Received: from huawei-w510 ([2401:1fe0:5::3b7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0ba31f408sm5225385a91.3.2026.09.27.11.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:06:36 -0700 (PDT)
From: Zhenyan Wang <maximwang110@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Christian Brauner <brauner@kernel.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhenyan Wang <maximwang110@gmail.com>
Subject: [PATCH 0/2] fs/ntfs3: fixes for directory permission and symlink consistency
Date: Sun, 27 Sep 2026 18:03:57 +0000
Message-ID: <20260927180359.3867508-1-maximwang110@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes two instances of non-compliance with POSIX
specifications.

Patch 1 clears FILE_ATTRIBUTE_READONLY when the argument 'mode' of mkdir
contains write permission.

Patch 2 leaves the symlink target unchanged in PrintName, avoiding
conversion from '\' to '/' in readlink.

The patched code is compiled and tested in qemu. Everything works well.

Zhenyan Wang (2):
  fs/ntfs3: clear FILE_ATTRIBUTE_READONLY bit when argument 'mode'
    contains write permission
  fs/ntfs3: keep PrintName not changed when creating symlink

 fs/ntfs3/inode.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

-- 
2.53.0

