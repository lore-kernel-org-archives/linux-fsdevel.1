Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2F2F8EA3
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787271692; cv=none; b=iluFl1dQgSOF2HruSA3Snu98HvPXPQDfXB2Er/AyxTQZdFE3Oi7jfU/olvL7s9v+2KMS0Oz+afjFhGR8gR7kCTx7hDHqtqJ8DGPzmBEzuegXphkrZ7Ly38n4K9nht5jMF2aULYkSbeV4Iip7EssCsaCfYfWZnNAhn4yHLmaJlWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787271692; c=relaxed/simple;
	bh=/wtgwmpyQyFZo+IeuIeMGBUymQzeBOcugwcF90wo3sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku44jhywOi7SMcUiII3Omf2+c8uDhWXYIoN9wVuWyEQQSGrzPzvIYJoCJiqogh5ks64w6LyGStIk71a0XWZcF9Mz2h6zRGdRtx9Mm1lyRI5oyWPnjRT27LBuT6y9lFcv3K1hGd3qN1mxFbcpAsAOCCxFCJOr5JMY2nE9Atu/Sb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJGazWmg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJGazWmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095DC1F00A3E
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 00:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787271691;
	bh=PEF45fYtrTiwHdPGuMmVYVdpsQnepreJgGvjjcdR5As=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YJGazWmg69CmHzyapxOtswNHd+7Q7r7dRlvyxmq+uBqL0mACX/tYCYVp5F+npeE0A
	 jy28AOSG3b2tdCiKFIctg7NTb+QtxrfAG/Xc9qJFcB86DInF3imkrDX/ZAGg+7Uq4n
	 eOBWa1JqIzaWDtDdG4ZwFZlhohCLuGdKjJmOBX4ZnlhwxUFZ6TX68Jdqya4GH2vDXr
	 BqODgxA6E+iSgDCTfsazI+pLG99x6QA893hS5yTLseJy0McF+tVtltRZ550Z88aHhL
	 kQ0ILFUeIhsSiPoI5i1TqSBOrdi47rJoWBQ7I1yugUFY8jeU92TFI1YWckxW6fNlBY
	 QZ8f6JU1tYBBw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so3033606a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 17:21:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq7xF22U4Uy4mW7VeuvBc4BVc9IWlqwo1E5WgMUP4oE3xuXg9i+5Jgk+EzX/gGIbssrKRPs7zD8RpxVFYPd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4aCW76cQGrbYGVg/XdUJ3yN5oWU8DDunuGlUH35sILnPHqkc7
	kZVGMJMO1B1OM+noF+NU8wWY2+SRqDBE01rUS0evR2zCyMctwl6bHApYjFjhEZVNkf6AxeM4q0H
	Jd2hNxmR52gwS8BvsWRKX6I9sAw/yUtc=
X-Received: by 2002:a17:907:724d:b0:c21:393e:6d10 with SMTP id
 a640c23a62f3a-c246d5eac42mr146920666b.4.1787271689633; Thu, 20 Aug 2026
 17:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a86a1e1.ee10049a.267d65.9802@mx.google.com>
In-Reply-To: <6a86a1e1.ee10049a.267d65.9802@mx.google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 21 Aug 2026 09:21:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_OwvKZJJ8FLrgiJk842ApEH1FM+A+=uFFTtyKmm5-zZA@mail.gmail.com>
X-Gm-Features: AcwNN1XmdVMpGNEOyxkK1fP0Sj7IY2yzOYFRqxHNcoptgokXC1Q3O0QJdVrlO1Q
Message-ID: <CAKYAXd_OwvKZJJ8FLrgiJk842ApEH1FM+A+=uFFTtyKmm5-zZA@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: validate usa_ofs before preserving the update
 sequence number
To: Dennis Tighe <dennis.tighe@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 3:42=E2=80=AFPM Dennis Tighe <dennis.tighe@gmail.co=
m> wrote:
>
> When ntfs_mft_record_alloc() reuses a free mft record it reads the old
> update sequence number straight from the on-disk record:
>
>     usn =3D *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));
>
> Here m points into the raw $MFT page-cache folio, which still holds
> unvalidated, MST-protected bytes: the folio is read by a plain
> iomap_read_folio() and neither post_read_mst_fixup() nor
> ntfs_mft_record_check() has run on it (both work on private copies).
> m->usa_ofs is therefore an untrusted u16, and a corrupted record can put
> it past the end of the record so the two-byte read lands outside the
> folio.  Reading such a record while creating a file gives, under KASAN:
>
>   BUG: KASAN: use-after-free in ntfs_mft_record_alloc+...
>   Read of size 2 at addr ...
>    ntfs_mft_record_alloc -> __ntfs_create -> ntfs_create -> path_openat
>
> Only preserve the old update sequence number when usa_ofs is even and in
> range, mirroring the check ntfs_mft_record_check() already applies;
> otherwise leave usn zero, which the existing restore below skips.
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
Applied it to #ntfs-next.
Thanks!
