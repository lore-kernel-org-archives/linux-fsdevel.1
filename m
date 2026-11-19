Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082461;
	b=pAF7Bt+PXrry3PQrRddCgu6Vofaywz0Lflr2E8roPm2lPGI+fcqzAtRSiIWsBTWEnGMS
	 lAwuut4S0ALACwkBoCrBZPFotg8cOpiTWzjPErkN7Ncp57dXhnkCPzIn2Towoo6dBJwvT
	 9BU/S8fH88zlos8cjxdkTJ9AtHQZ2mL0OTY/wCAYeZMxatEEc7ggiO37X+AcFqQqP7Sp3
	 xtXWPplbP2vJ1WuTwgjWjlwhVzn0wOzQt9nWF8k26VHjGoRtDxFljERumnhEDNRTupn0n
	 ZW4oyQZFjpoXaTowlIKrwVLxf5MEj0bxyhKovOEyY7owQiuHy8I1aUBmx/ranZLDQlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bQXf7a2tchZd0sm6ejvBeIAXUJshrV4kEWj9Zx7JZ6o=;
	b=35kJC3Z5t4gwEXL7857p1RucfDJGkkykZ7vhPC5frYXHQyxvQ6W9eEbnoKKDH6vjC50P
	 xsofgCArN6Z2aTfpUk7VMe5Kv/ShtxoK376oU2+vYFh6kT8pN3mz+gHAbicjk0HLyjj5q
	 m/lHhkLNjOoyKAa6nfZxeAoekf2tEg9LH/iuZfoXqaT+M1mUQx5/VTg41FAoGmkqaHwhg
	 6Dhei0XS/B/e1i0GPx5Uh0sbvtexg0PRPRj5yDVYKn2zg02WloshAGQjeRVDy0rtfMov1
	 qO/z8K8vSSPAwa++wU7EEhBqyNYf8pa+H5+q9meu1R7tPoWMwE9ud6IdW8Y6npxvFyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qQtx8HcI;
	arc=none smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359DD60A2608
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 10:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 359DD60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qQtx8HcI
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so18867381fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 02:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082459; x=1795687259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bQXf7a2tchZd0sm6ejvBeIAXUJshrV4kEWj9Zx7JZ6o=;
        b=qQtx8HcI9xOYAewqsC1qeKXYpNZYkorGxO+WUf8GNlozJTjTfjp6RYu0ME9dnQS7SU
         QlKY2a5rrUaalMRM2QkFx1q2fMNmh0+6Kx9oHBLriNElluMZgw2IJqtD+3DSP2pgxNzk
         2TmsS6xkE/qzDTWdZfTpZ+KAbD1lTDxAfFCzr6drsaxvmeBYV8fzzvm70Eui4lhqXTnh
         HgbHImFNfpvHwHXydOauwOfe17ING4Q6TVfyd4rcZEWzKr9mr4fzMJ+Vemn7/3JBMyOg
         1EBPQX8TZZCNUbaVOuHs0Ki+dm4jvN/9bSy06FQShgIIqQcy0wSxBtWSC2/KV4f07jNA
         MUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082459; x=1795687259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bQXf7a2tchZd0sm6ejvBeIAXUJshrV4kEWj9Zx7JZ6o=;
        b=vMICc2FE41IkS7F1yKtMH0l+XvNpIa2ar2pGw+3n5fsLrYMFriroqDyTzpJe3ekTia
         FtWxSPSnqUtC/5eK/8TJtM2ADtuu/kPYLETXipG5fhI670m/th6PchMXHD0Z/zT4xiBZ
         p/Hx+5Uza8lhGlK58Aot1g9PKMHCOGZDNcMdsBYX8pEfq+tuidWDngxAL3Xlf+7RU6Wy
         BGbtjF1HehSCgifbbb0qg3nX7WAuNjsQe4kGmx32tOHMI/EoLKr0r37BdpwADrDAy0Ml
         ylxMxx8VbQTt9/j1dx2ktDlRjbI5Wh7gaVrzkgp25akY0186pHoO3sHnVQemLdVtN9Iw
         ZtxA==
X-Forwarded-Encrypted: i=1; AL+hErG8Omnt3NVeoY5Yx8PCysioWkOwUB1rXnb2xH3F8fmTAGCCfWpQItLQY3nI8QUHRMfnNR8yEi8tdU4X074p@vger.kernel.org
X-Gm-Message-State: APuU4Z/1VbYE3N/ttrtTAfi1OMfHrgmQzitnLMpyRHEebe/Znvu8/RYz
	EXhycRF9mrlgoTOe477xnj0fyTGKLcLneEVGvYmYSWjj1/mB2yPYHXf6ZDsir+gnhj4=
X-Gm-Gg: AYBFou1mzsv7MjvtfbdfDEgGss/jRJra+b33aBuKe0m4d6lzg3ZPOnzJ/5CpceJ0U2R
	CIWelgvQ7wR1mrfyX8PTr61D/WnKrGim/WlAuxdqKtuZqBcR6kdzXMRJhOyYoaZ+J7Hvs3C/RnY
	FfFSDOZDXCdVmNHhra0Hma0SppqZfuxXPYVugtA2/VIEKV05WbML/eHNaU5PZDUhEWu8fxJDHPv
	vBkn5wQAvPogswmSuPm6PNIFOKQJ72uvo44FIlBishvmagay4dkLN9kJ50+o1iLrqBBKbLiEHY8
	TK+4jR08+NlcOkXGNKId0oWa8lFzGUFsXpCsMcIItrhHC405jA463phn8ugq/qyt/LvKYChecyP
	ErVkrIb0DQXI4ucJOjMtQNff0l5EH+XJISCnHj+fbXaXJHXDifM2Z2ZKbAKAfm6oa+lbDGslvz6
	J0dZWxFVVQK5UYwgR8EGozQvH65qAl7MW3ynBT4NsO45tEkzDasfmbyh4mL0wvOCE8NuQnivz/r
	1ued8+TcwV/63z3Bh4GIWGBVNbgStFOlOFLhiBFWYnPgbJu5cdju26D39+rWJK4bp1ej9Kembfy
	Zp4J2pTYNUg2d9GZnwlCIvCBXyXvX6N3pSbonIW1lZITFj5zpkYYxybWt3tS60hb7Jady8OGZpO
	F1xTtGOHK/tzOWx1OlhxNwGRd2hfdTRiFHJ99uoN9+SZ0e1teE93t6EIaAHg=
X-Received: by 2002:a05:651c:1987:b0:3ac:7ad6:2003 with SMTP id 38308e7fff4ca-3ae670dda79mr17356091fa.6.1795082459145;
        Thu, 19 Nov 2026 02:00:59 -0800 (PST)
Received: from Lauri-G-Pro-14-M4.intra.lakuz.com (n2vuxeervp7z67jbft6-1.v6.elisa-laajakaista.fi. [2001:99a:2ab:bb00:352b:8deb:4901:b3ca])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae6ea7c798sm8419451fa.11.2026.11.19.02.00.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 02:00:57 -0800 (PST)
From: Lauri Gates <lauri.gates@gmail.com>
To: Dave Chinner <dgc@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <christian@brauner.io>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org
Subject: Re: Concurrent FIEMAP on reflinked files serialises on the AGF buffer lock
Date: Thu, 19 Nov 2026 11:59:43 +0200
Message-ID: <20261119095943.85048-1-lauri.gates@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <av4Hn9u80fs8iHZ6@dread>
References: <av4Hn9u80fs8iHZ6@dread>
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

On Wed, Nov 18, 2026 at 10:16PM +0200, Dave Chinner wrote:
> I really don't care if it is exposed by statx or file_attr; checking
> the flag through either interface will be orders of magnitude faster
> than using FIEMAP to iterate extents on every file to find shared
> extents. My concern with statx is coherency - it runs completely
> unlocked and so can race with operations that add/remove the reflink
> flag...

Thanks, Dave and Christian. Given Christian's preference and the
coherency point, I'll write the RFC against file_attr, once the
question at the end is settled. xfs_fileattr_get() already reads the
flags under XFS_ILOCK_SHARED, so the new flag gets that without extra
work. The answer can still go stale right after the call, as with any
stat result: a clone that lands after the read is missed, just as one
that lands after FIEMAP returns is missed today.

As I suggested on the 6th, the flag would take the inverted meaning,
so that an unset flag stays the safe answer: say FS_XFLAG_NOSHARED
("no extents shared with another file"), read-only, in
FS_XFLAG_RDONLY_MASK next to the case-folding flags. XFS would set it
when XFS_DIFLAG2_REFLINK is clear, and ocfs2 when
OCFS2_HAS_REFCOUNT_FL is clear. btrfs keeps no per-inode record and
would leave it unset, as would nfs and cifs, so their files read as
"may share" and a du tool falls back to FIEMAP there, as it does
today.

overlayfs needs care: ovl_fileattr_get() reads the upper inode, which
for a metacopy file has no data extents. The overlayfs patch would
take the flag from the lower data inode, and leave it unset ("may
share") while that inode is not yet known (the lazy lookup on
data-only lower layers).

Christian, one question on the shape within file_attr: would you take
the inverted flag, or would you rather keep a plain "may share" flag
and add a mask to struct file_attr that says which xflags the
filesystem reports?
