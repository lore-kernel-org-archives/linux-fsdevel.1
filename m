Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0221643551D
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132888; cv=none; b=AJv60LqdyR1nKFw8goOgu3qfsMnaC/EyXLWz/GNvRFrqJRNIufPOvIIan2ZhfswdSrFC/38sVZcYRnpWdtWvPnbzBZ/woVA2meoDunyXuGeTSkYz685Oh2RFYXtNOY+0msf4HZACVmFg4Aq3w2CDHHmAUWCSh/H91tAD66ZrK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132888; c=relaxed/simple;
	bh=RbXNBG8LGuRCcujXLeo2UsCVeBDRyBnnFkLsfIcjcQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpK1JiHlKE6YTiKHvbVtaG9x1wYEbAIya05zBy3KzbGD+ydRYWGZbbCCsoGHuFJgN1xsG5ZXvLxYceBs4z/gPiTl1aY5QX1Y9A9rlMSeATjFBDyrvMu7jYbSN3xlvZEUFnV65mH/cZ6lnzmW/a/UKNAlJVH+vzJyzT6bOgIh8EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mep8P7fH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mep8P7fH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EB31F00ACA
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 09:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787132886;
	bh=RbXNBG8LGuRCcujXLeo2UsCVeBDRyBnnFkLsfIcjcQ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Mep8P7fHzy9RoNytMI1Aba4u3MNX7P+6oK/ksoErYu+T9AGSuVkf0C9MMxhHl3KaR
	 ExkOJ5pgOGuwK8BpSKMZ+pQ3BGe+N9KWO9JmMAzOjZH7AMzMB4vCaRCpnQ/kmfxLfa
	 pAby8Cf/OXhpj5oFHxKPFfV4yhOgt+3rCyJlrgz30nNE+kVxOTQ7N0p1H9JsvivTBJ
	 C0lvCfazr7EIJoOW1IIBVyNO42xWixgeYRHA22FL84qxeIEvaFPVNgRd6chMYeHfxt
	 0kZMj62HKgqM3C8/AgCKJKq0GPh+oF/Mwf93qCLVL6qjPlIIzCA4BsAfqe97hqLze0
	 4of3j1y0gYotA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so83159666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 02:48:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqRWy7G2V3UKd/V723UM+N9QmkfKMozBQz78EFhywa17xjDbIqG12w0pFzIY5cMt5GLjr43t5nj3TprKA2z@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2kbNWhEbui1RKEXcFvC8mAzhczYTLdGYCqAWCQJikc7RKzae
	+iHyeqnGEDTvp0Y2ciCIa8q5AYx75NfYAN3T68SZOUVHBiqhjmMGIKlzV2CIVWO5yf8j600JV9g
	/SxjiDVzJMROjqdPj6sSQp6b2OZ3vPd0=
X-Received: by 2002:a17:907:5cb:b0:c20:53c7:488d with SMTP id
 a640c23a62f3a-c242e364abemr181751866b.14.1787132885292; Wed, 19 Aug 2026
 02:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818082740.498458-1-liubaolin12138@163.com>
In-Reply-To: <20260818082740.498458-1-liubaolin12138@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 19 Aug 2026 18:47:53 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_xgHT=xDQMEGkKASZTtWU=Dv9k8r6zV-r0doiWcxt7Mg@mail.gmail.com>
X-Gm-Features: AcwNN1W2tOvm4S8WGxsdl5JHRq5dSUIMgWPk4LJxsZuX4yRwGNf37D_8n5Icu3A
Message-ID: <CAKYAXd_xgHT=xDQMEGkKASZTtWU=Dv9k8r6zV-r0doiWcxt7Mg@mail.gmail.com>
Subject: Re: [PATCH v1 v1] ntfs: do not update ctime when setxattr fails
To: Baolin Liu <liubaolin12138@163.com>
Cc: hyc.lee@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liubaolin12138@gmail.com, 
	Baolin Liu <liubaolin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 5:28=E2=80=AFPM Baolin Liu <liubaolin12138@163.com>=
 wrote:
>
> From: Baolin Liu <liubaolin@kylinos.cn>
>
> ntfs_setxattr() updates ctime and marks the inode dirty even when
> the operation fails. A failed setxattr(2) must not change file
> metadata.
>
> Update ctime only on success.
>
> Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
Applied it to #ntfs-next.
Thanks!
