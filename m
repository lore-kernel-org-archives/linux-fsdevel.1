Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079732;
	b=pVLwpQnVZIp43ojCscyEJ3SnUCREiyn5UJXrK4z1IDCfUfF0AMGFPSR8J0F9pL+FNRNM
	 OWuYJqa8CDX92pAx7rqUmnvePe8/m+qAKNGpFTCqFGdTswqjdUyjBYbt5TQItCgkofK/Q
	 llMvnxjtxiNMS01IZgi6TaVSIoLf9DyT1rSm0kB7K3rN80vKmKtiqOKQloSnhcubO4rfw
	 BuOQV952ewhgc2E7eFg1/X9XlqLa5Hw1pmBLyjTB5t6lu5GVXfPECyrpJ6yIjyO2D0Jjy
	 pAAr/h5ey2TURZoWpSTXj4VuO94AhFeIA+Tkv+Xqz/i3w7ykPAZ8kPnCCriRp+Fn+EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4YvQ88Tw3BpTAX+GwccgHZpr8xDWaxtWSxka8yipfg8=;
	b=Y1OE6IQXjf6Gd1S6/8vqI4YZRNEzulCWX9uSsu9C37FhovjIK+XKkRK7l8Cc0kiIM5uy
	 0eX7kwwlh5WoAZoaJpIxLCyIPodcE1iIXrBqxsNPIkVI2KUiT+dv5+p45682qx8ffALjp
	 zmimcVQnlC4Xrpb7+V0b2VuxkA7j/4snes7rVit2BTh7+CPV0uPePMnTYN7n1G7B0uwFu
	 xMNo9hOEQM6GlQS2QPQBI1rxbGHu/xl1SDaSCuzQngCwMcqyVUXBMpO5xVu+LKwQbaskP
	 89gzWZkT/hg59zFiXDKd5f67wK1qDMZzqC9mp0vb/yxT+ckr8QD6Pj35Mxt1WiD4vsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YO5yP8qC;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E531606A32C
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2026 19:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E531606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YO5yP8qC
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3282db206d3so50934eec.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 11:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794079731; x=1794684531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4YvQ88Tw3BpTAX+GwccgHZpr8xDWaxtWSxka8yipfg8=;
        b=YO5yP8qCHZt3E1p7kirdA3BaQ/nmYjlsW6tYhTjLTm7hN0UMx49b/eckfBQdj9h3Ob
         Iwq3aZM0S8PHvI0b/7XMozBn1SEYbBxVgnaPCgkEc1jBWlf6LD3U7QiuAlAs5yI/STBA
         QnpBx9bE8cWbQ2Vq5EGysf9+rAue2S6KdRMwBrdl4EwllbxX+EOAZ9hzgWXQooFCLGnl
         QbqheRZMzHkt2ye2ZTjB1YXBkH/VNHKIiNPWpFNYK2wukaVo+QMth0DRU9W4nYWCE0tW
         jU9JEDMea7K3oxpyJ4cyVopstrPMVs5j5nz8USvb+UymAO5RhaiKc8Wx6ArBEWv7Tiuz
         Ax2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794079731; x=1794684531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4YvQ88Tw3BpTAX+GwccgHZpr8xDWaxtWSxka8yipfg8=;
        b=X0CVP9+eOBkqdVi8DK1gDU28rV8glL1NjsYhGXvtXThqxgnyDzONW4Wws5GzZfeTDU
         YJXTTZBS2hT+GppVMlRZ6Ckq4KPpUeJLO9Ho5P/pziS2YCgs+E4ayaEQay2w6srFuKCi
         wQ6FCr8CKe7OaEo2+J29Q6s62loM/SG3nDHfgqztrNCNqgWuYciVFi1xbnNead3/guFn
         Lzf2rtwQ2KfYrAQWpHxPUKVIHqlG5vKGUe7qOKptpUoMD9WYrt+nlBco0m+m//Bh3Vpk
         q32g65vO8tGVhbPy19psA3qylcSVERfZaX6lLfHpqjm+POyigjuenJpfR/MTOrVpYLta
         Rp5Q==
X-Forwarded-Encrypted: i=1; AKwUvBw5jPOuzikZHOrJTlymZPZqhb8plAFdJ6ULEWp8WL8sU1cVl6RsR8fyBwIE2qrtpOenGq9kV03X5FR0CXGO@vger.kernel.org
X-Gm-Message-State: APuU4Z+3gPBupFvVHj+j2FAfntdLKw84eSCGTntgbX7g0JcFwzaMQpo9
	CCvMlmv1HKQy9XPv811iOhGSfsNhgdkQCGKe3XhU0FTXwBfK+AOeQVQ1
X-Gm-Gg: AYBFou0D+cRHrxXJy0Xpr3pg8d3HhmSlJaLOIWS8l/aEzQ5d3WcG7C3uP5B0pckPUtY
	BlN5VCVRgfbXF3CT2qX5bxxPUk87ATBUzPIaeXxEmvYffsU9rlb8iJWbcdvrf6i55v566FXISCN
	sRhsebSDHXoi3adxkzJcHa1HfXXbNaxngEcD30F+dgYIwHmJyrTXrgFLZX+ZGhkDxV6KeCarMX0
	uBZ/Cvj7PhF3I4Nj0P6lbglFJR0YxiyS5BieVepWJwVOP1C6a4Yyn3nVGdneMfrfuVrdGU6WjLI
	ZPlDWtjDSW9JPyvduYeEinLsc1UdUDSwinz1oiq6j7UbTtTXsBkdsgnZvKs6njJhvdqXg04xVD9
	GNIyanCEhyfWUAF0sMfPTioWWGA60mo5N8mlS+h+gSLGOW2JXSk1p2HIERW1XlbldUeZxyeb5rK
	Ch57CHWwlp/yPxFgTln4HRw+keUw4gNKVSl/qnsJV7yvclh3+wsg557ZaVGZfVEbWt35baCGv4y
	83ak21fVa5Rtg5rDa8X+ewdXbuj2O/KbF+I2G10UGZnW/O9dfFXwi4ydrZIgxFY3kMtkvGFENYn
	eIySPc2xMsfRXgtTJMLGwNd5HJ+901VUXY3zgkeu6WS6YrlfbLTGEw/Dc57WHoyWYw==
X-Received: by 2002:a05:701b:270d:b0:1a2:2da2:b278 with SMTP id a92af1059eb24-1b25d30af61mr9520523c88.14.1794079731268;
        Sat, 07 Nov 2026 11:28:51 -0800 (PST)
Received: from anon-laptop ([103.187.196.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e936bsm551856c88.6.2026.11.07.11.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 11:28:50 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ntfs: do not convert a named $DATA stream when making room in a record
Date: Sun,  8 Nov 2026 00:58:44 +0530
Message-ID: <20261107192844.3908575-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKYAXd-68oCuAU=x0TV6BMsNJZkmBcdVZTtOQXh3iEm6BptJSg@mail.gmail.com>
References: <CAKYAXd-68oCuAU=x0TV6BMsNJZkmBcdVZTtOQXh3iEm6BptJSg@mail.gmail.com>
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

Hi Namjae,

I sent v3 of this patch as a reply to this mail. It opens a named $DATA
stream with ntfs_attr_iget() like the other attribute types in the loop,
and keeps ntfs_iget() for the unnamed one. With it the image that
triggered the WARN mounts and walks cleanly on a KASAN and lockdep
kernel. Without it the WARN fires at ntfs_attr_make_non_resident().

About the lock ordering: I checked the code. The comment above the
__filemap_get_folio() call in ntfs_attr_make_non_resident() says the
folio lock nests outside all ntfs locks, but its callers hold mrec_lock
when they get there (ntfs_expand_for_write() takes it in file.c and goes
through ntfs_attr_expand() into ntfs_resident_attr_resize()). The read
side takes the folio first and mrec_lock inside
ntfs_read_iomap_begin_resident(). So the two orders do exist. This is
true for the direct conversion at the top of ntfs_resident_attr_resize()
as well, not only for the loop.

I could not turn it into a hang. A reader and a writer racing on resident
files, also with a delay forced between taking mrec_lock and the folio,
completed every time. So I do not know how reachable it is, and I did
not want to change the locking in this patch on a guess.

If you want the order fixed, I think it needs the folio to be taken
before mrec_lock in the callers (or a non-blocking folio get on the
make-room path, which only tries to free space). Tell me which you
prefer and I will send it as a separate patch.

Thanks,
Wahid
