Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301336;
	b=XPR2a+MXHlzZbn9iS9KcZzgl1EMqVvhxGZHvJn85YYUXGvH744N0G0Km38Vtla7mSECC
	 KaIeumM9pcL0YkHZikCi9i/4edB7KDdYp6SdPEeC3yJXA+kCqBOS4vUldhlo8VIkcWALP
	 V2Tv0T9+odkUgczu25dI/JGx9Jk0GoTkMnizjWoGQ+34AW8/WJaAJVWyEuTM2s3tZ2NBW
	 HXUcvczreVypBoX9JaIrjlnLl9gwxErAX31v8wRT/Av03IcX7Bys+v96BQTaogHnYRpAP
	 ngG1W+EspM5m+KqoBsDxKwRGPhhMMwQlGsG28OIB/dwCcTAz09J8ipvYqt2fU5dP0UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301336;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=31mcYN2SV944j8hgXHX30XhSqV8ZOjU7NqIdk2SlnAQ=;
	b=ZnZxSbzKtnFreeJZRZGp42SzZDQl8DtkjujAAjaGoFA3a0t73DP/ST6pdERKXxMVDAwI
	 iH6t3iH5FY/Z22rw/LYDtUFNC8HL6nHnGFlcGW6ii9UMh30d2fpMfPKXYSNvJIqhItEJS
	 9O7gagetsG5xYUx2W7+J1Q8BLfCjahX5eCgpqbDW8aO1p2fVI/ThIvPDR2VIaCvI+3y/R
	 3Bs1xQjnsLY2wq6moUXP1seX2y6Pvw3aSDmkkVOCEq9bJ8yCetjQFELAMD/WEItLjdy3l
	 P6i3u4I1J7KsqLKwSxGYiTldb+UwhDTt8YgrWR2DHBjuSmCZ/QbrUnSDyG+ldFD6z7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=goWGiF4i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA9F606A31F;
	Thu, 29 Oct 2026 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=goWGiF4i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4FA1F01816;
	Thu, 29 Oct 2026 19:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793301335;
	bh=31mcYN2SV944j8hgXHX30XhSqV8ZOjU7NqIdk2SlnAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=goWGiF4iiE+gbSFvk+JBT5csr8Xk+phJK1z6CO6BrKfrJ01r2e6Frmv7UUzpoo6Z1
	 5z6xu7j2x6LuloDRbPlsj1u+LIJEIBBKCSu8nv0ubftmT+/pIxWa35vOSYFkSjZnNk
	 33r0tlgq+7yBIkbTB7er1+DO2873m1P3azaWvGAc=
Date: Thu, 29 Oct 2026 12:15:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Hungyu Lin <dennylin0707@gmail.com>, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: fix parent link count when replacing a sibling
 directory
Message-Id: <20261029121535.3347dc93905f38b23aada5cb@linux-foundation.org>
In-Reply-To: <87fqxpdp60.fsf@mail.parknet.co.jp>
References: <20261028211626.26103-1-dennylin0707@gmail.com>
	<87fqxpdp60.fsf@mail.parknet.co.jp>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 14:57:43 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

> Hungyu Lin <dennylin0707@gmail.com> writes:
> 
> > vfat_rename() and do_msdos_rename() adjust parent link counts only when
> > updating the dotdot entry for a move between different parents. Replacing
> > an existing empty directory in the same parent also removes a
> > subdirectory, but leaves the parent's link count unchanged.
> >
> > For example, renaming one of two sibling directories over the other
> > leaves the parent with four links instead of three. stat and ls report
> > the stale count, and find -links 3 does not match the parent.
> >
> > Drop the parent's link count for this case after the source entry has
> > been removed successfully. Leave cross-parent renames, regular files
> > and the existing error paths unchanged.
> >
> > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> 
> Looks good. Thanks.
> 
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Thanks.  Sashiko asked a thing:
	https://sashiko.dev/#/patchset/20261028211626.26103-1-dennylin0707@gmail.com
