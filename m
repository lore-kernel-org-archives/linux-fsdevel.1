Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521142367B5
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776492999; cv=none; b=Tl6b3fhFU5w8C0NwM051FWMaU++17IIx8OPIAdoBg1yq7PGvywBmwvhkBbEGom8sWKp98pEluMai2PaB5puUmpDo0UEEgzOB6gPtwbqQamN9bMytyKf+73JwhvWInrGz65ywiFVicXrRI7E/y3QMSdVkErBrzNe8cadSEGFRLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776492999; c=relaxed/simple;
	bh=CQNapxLOS6PFADmEUnHs+eXVpPDfi0eLdJ7ithaYetg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzrFV1XcBvpWslGy9xUwr8it1hqCxA9mk59M97zwqBEKM3m9REMrxiaUrTbXKqsOkRRb3YB3J+LtTNBfMNTvBua2Gi1RDqzjXjXnOKjRJVhfphaIwq1YD5gZpctbZR3zuNZymP6GxAz3zGddlXAXxvjKsCuLmCHDdKWhf1560qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf7258875so151549f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 23:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776492997; x=1777097797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cL9/O/PAg3wzAE4bDYDZOv/EHFkcw+FmE+GDn+dyams=;
        b=VKuTGBs8WwxY75t48D8x0iET1yjUQkaBFuJQMp0c7dOuMwILx64r1/E2v9Fe3/iio+
         OQj4uG68yV90nRGK1LQ+m9fQdBsWqOuu9eDtNDBpyktyotxAHa7gLUVISg7eZeT6sA3C
         PJrSuttsjxi2XIPm+3uNTBZUdTgDJSNw/Z5GVpEvu9lBVFka2+ESgljq4WqY82e14wuV
         L4bq7LG4akEzQKegCPyOAVPwHw6wz2e36S6AwQGlptiROohLxU/+LsJLHaSSCMf+UdeH
         4huOT9HRklXl1iP4FAzKt1MLKwaEkYYsER1jnQEEPyjckaD502GUsabfVrygeoNP/e+5
         Jvxg==
X-Gm-Message-State: AOJu0YzvK4ViELp+h/3BpqnaZxu+/+FHtAb1Vp6yf25Hsf6oSG9jeNA3
	hOxvf6yTqQ8lQWwAecZpuPkwjZs5OSV24SkqmqwTbRsMDipJjrbTl/1/4GoQdkss
X-Gm-Gg: AeBDiev0EiXgN7WUhZBuCimpnBrDdMN580nroKPL8H3j0OHnaKDBS5LTy3SrXWrTfXu
	NxIJSsWph0BvVmj3S8gRZxlOsiRtpfR+3MdLeFQoWwf/enlDv1LNM7A9bLUO/x7WSdjAsBIkMYJ
	B9diXp1bHdjmVEIi9iBo1O5P0rAqg8FEqqNfpgaDf+rIYChWxmyncbJMC3q+IosEpFPR6xnMwkA
	uCxVox6LmSLjiJXlgBxrQIG56oE5FGrC7gguf/P9eqEeG0YjRKvlBpiXmMG/0zzt4wyc3W5A9Xv
	iF+a+iJX9cWteUBJPlodiPswqx+rPG2ksbr5gzRLtzGnEg4q9z8CLi+y4IG6WcBpCe/3nFv4Mlu
	JUi31OPl0ZaretU7/IJQibrAyQ/Xt4zvfZgo/MMiJyJlA+nKC0KDhWFA1qJGMbAUBpdNdA62h8Z
	Yh8Fs56Y5wTVfc7uDfLCB/AKOBEnfM8lwF16wPKB+5YNcSdJaGjELq9MhY4Ga4lqXIAmai7JP2M
	hk=
X-Received: by 2002:a05:600c:5252:b0:487:575:5e3 with SMTP id 5b1f17b1804b1-488fb78bfe0mr47240145e9.5.1776492996461;
        Fri, 17 Apr 2026 23:16:36 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c96b4sm166248705e9.13.2026.04.17.23.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 23:16:36 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org,
	adilger@dilger.ca,
	pfalcato@suse.de,
	Aurelien DESBRIERES <aurelien@hackers.camp>
Subject: Re: [PATCH v2 08/11] ftrfs: add CRC32 checksumming and Reed-Solomon FEC skeleton
Date: Sat, 18 Apr 2026 10:16:26 +0200
Message-ID: <20260418081625.2265166-2-aurelien@hackers.camp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414173423.GA24456@quark>
References: <20260413230601.525400-1-aurelien@hackers.camp> <20260413230601.525400-9-aurelien@hackers.camp> <20260414173423.GA24456@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

On Tue, Apr 14, 2026 at 10:34:23AM -0700, Eric Biggers wrote:
> Is there a reason why the kernel's existing Reed-Solomon
> encoding/decoding library isn't being used?

No good reason. v2 had a custom GF(2^8) implementation - rolling our
own RS arithmetic when lib/reed_solomon exists is not justifiable.

v3 (<20260414120726.5713-1-aurelien@hackers.camp>) replaces the custom
code entirely. The codec is initialized at module load via:

  init_rs(8, 0x187, 0, 1, 16)

encode_rs8/decode_rs8 are used for all RS operations. The custom
GF tables and encoder are gone.

The v2 custom encoder was also incorrect - it did not produce codewords
compatible with lib/reed_solomon. This would have caused silent
corruption on RS-protected blocks written by mkfs and read by the
kernel. Fixed in v3 and validated: mkfs parity matches lib/reed_solomon
byte-for-byte on arm64 kernel 7.0.

Aurelien DESBRIERES <aurelien@hackers.camp>
