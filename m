Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987065;
	b=tQ7Ck053FcTIwR3ERIlMZxo4bW9RoSRx3RtKmLDkC3Ud/BOCwbThmmRasd8u5qT8hh9o
	 gLgEAGR8hVDmpAyRkaeNjsYd8n54CtsWy56xLnvUi3MlS1Yu+95A8aU9kWuwHGTVBcYDp
	 P+zrrJfumzzuNxZrPQo9rp9pV9FvJyzSgaTq69bhazW/k/npys8l4zRke1qqz/PQqUTT1
	 6c+e0VpqeRjbXC6gWZ7dmP7T/LFadShSxe7sLeCz2bBPta8uIy9lHeSBZLI2L4PN1Kv01
	 tvExgorlNTNsQejxGJfUX8WkCmX8UUyEO/EJK9FSgsyrNStdjyRwlWczDTbisKcBUwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0J5dycAQyrXi+H6VpoYIGTGq8GdbI4+vkynl3svKXOg=;
	b=qzC7/zI81B8y0Xkl6Ufx8VvxVhvXhDYW3lCr4PVwbi3q6TZ+SC6Bdp3W4V0idG8AWgt3
	 u6scZ7aCWHFpy5zPe0YJ/wqX+LYvev/gwtJ8D6dzOQIricb4seVzjdmHBhyulXUU+DwFU
	 9cB8tjW+dyDLYw5ociG0f+W4FuSlsB31eUfmj6V6ZCmUAzJUaNLF3oUPR6h+P3h6UlH9g
	 monkWzbnBlbbsNPdgyMuB6dtUO5P+iHWsXZXJIxcx3D7CJd8DOJzCjEP88L2inWbewqIA
	 LVUCGXvLVlNAzIdWMGuhi93EGb7oFFiayTvZO58tidGYQLqNt55TSGh9rLos6jv0rIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iAzhnC6Z;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F0C606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 07:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56F0C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iAzhnC6Z
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c50dd1e2f11so80866766b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794987064; x=1795591864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0J5dycAQyrXi+H6VpoYIGTGq8GdbI4+vkynl3svKXOg=;
        b=iAzhnC6ZeE8qzx1JdcZTlHUSXA/9zvovXFevq4333M/ceTzJ21m5otRh1It8cwjBu0
         fGFNypOgpa3Uel/9HuXS5Y7k5QJETpP4OzhFD9nziZGZOyd45EH0Sa2oWM+LbM703Qtt
         wKFSbRPw5fT6bVrepVwauXuGCS8+2ql4tGPvEBXLQGgbXfGQCGmAjfmaPeiQqfXtr6mj
         uV4dZLl+y+ZXXBxwYLziegdFrf7kCRghzN5vJQ27U6GHU4fO5j0RfuluFF6aTXxrNxA9
         6e/8bBMNvsg+rC8CRNHABep1qQui/ulfzAChSimIzZS+CZ274bANl/xJFgtPX8UxaVFQ
         rzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794987064; x=1795591864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0J5dycAQyrXi+H6VpoYIGTGq8GdbI4+vkynl3svKXOg=;
        b=LCrCcueu4zp3CdFHLevCeNwlbb6Lxb0Bh/qXTkQCj8pfSJ6pZ6yXRkPSx1axRtpG9y
         GxMbuQI3uwx8dI+3vnY3cyPZzgaR0wlkFG4ijsyCJgXxabLhJ9+O9ml/Xznx5qPj+ktV
         O3m0qe/o9St0Eruwj0l8Q+TeuiT3UomUVKmnZj7+vNozKfdHfvZqemDBXre8rLuEzC3N
         qRt3YBVkt7UsDZvfUqIrGDPoyW6x1NEMTFXof0PGD8GbuRyxUj2SkYYoB11N/Izug/F8
         IJHnrE4z6FbmNAruJSq3YtaPLL6KglU5ouF92Ik3G7HTxBl+0mF21iTPmRiIoUFxpy9s
         ptBw==
X-Gm-Message-State: APuU4Z/lBDFvhmPgmFy1NLXT+8GzpEWjb8DVuAytxY40/m6vMbOHIslJ
	iVc8ziq6qRTgABbC6Bo/KIxHHo/iEkWW6FrkiVIiJCIktKZGqOpH4+m6
X-Gm-Gg: AYBFou16/e+t22a9PX10BzpSVLy1D/DlW5Bt/MhQsiWPE2j2/puC7hngbX3NK+g1vLU
	POycopE4ObZJ7nik/mGfDCtCwBTkED7ys7CINoBJa/Np94EIMYNlqgpqY0ZFCYbVhwmzgfiTXLG
	yCbtP1fJtrja6M6EkKmSk3cIhigOfxDEjouRT3DAF6WtzkmnnxnwmvBGWrZ4P95d+f2ChTObByb
	blgrtxYew7A6HR0KafZQvpc/PwBPrMJCy6roA0mW8UAu79p6wL+fkoWm8vvGMYGwEJVYU+EdvQZ
	IDAZMIp4vaUhvLgPjBEopFUTZyATMtkAAxMbYXGDsEOUZgu2ZtEqKn+C/su9YMZc2popnLMdlXn
	IHD2TKBrYNqJXK5Z2BiUZD7vWxxayY7ohM1/5IR5wp0i2OfCiqSv9b6K4o1eBVwXNKDNsASq4Ko
	rUMzs/ONMleX1ke/ObG6z9RW8/8FeZ0YXz4d1KxwbrewGX3Bfzv+v87tT/8zdOnzmpi/Cl1lnS+
	Ie49UGQbyNV6SfNyUTnU47KyWN2YqEAREdekyL27fhK1E+WBCek1V2u8FXpwwSqnGCmxT6dd77K
	Gt6a4nP6YWX7ec0AwVmfzmw841slcL8r0B4Iu/XZY417vWqq+45JmAocCio9vg+l6gExMyUXiDH
	8G4BXsRMuqDY=
X-Received: by 2002:a17:907:6d27:b0:c2e:2baa:a642 with SMTP id a640c23a62f3a-c510e4d265fmr134087166b.30.1794987063521;
        Tue, 17 Nov 2026 23:31:03 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83fb8bsm66189466b.11.2026.11.17.23.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:31:02 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 0/6] ovl: restrict pseudo filesystems as overlayfs layers
Date: Wed, 18 Nov 2026 08:30:56 +0100
Message-ID: <20261118073102.1216568-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Christian,

These patches are based on vfs-7.5.pseudofs.fixes and replace the two
patches I sent on top of "ovl: refuse data-only layers on pseudo
filesystems".

Pseudo filesystems are refused as upper layer and allowed as lower
layers only in legacy setups.

Thanks,
Amir.

Amir Goldstein (6):
  ovl: do not change redirect_dir=follow to on in a non-upper mount
  ovl: do not allow offline lower changes with data-only layers
  ovl: refuse pseudo filesystem as upper layer
  ovl: refuse pseudo lower layers unless offline lower changes are
    allowed
  selftests/ovl: test pseudo filesystem upper and lower layers
  selftests/ovl: use legacy setups for pseudo lower layer tests

 Documentation/filesystems/overlayfs.rst       |   7 +-
 fs/overlayfs/overlayfs.h                      |   4 +-
 fs/overlayfs/params.c                         |  19 +--
 fs/overlayfs/super.c                          |   9 +-
 .../overlayfs/automount_in_layer.c            |   6 +-
 .../filesystems/overlayfs/pseudo_datadir.c    | 111 ++++++++++++++++--
 6 files changed, 131 insertions(+), 25 deletions(-)

-- 
2.56.1

