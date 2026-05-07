Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A783F1657
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158378; cv=none; b=TMITjcTds1ayFyTCGaFhOuk9Fe2Tf+jB1u21ClwzvOB3JfvNuMiEZdSyhD6MLbHm90hxA4VCvlZug46Oi8eTOkHgH+QSeT9B2CRoSkQaylGhrMnhV+A1PSCkNyX2k5FxeTwI1iJ2wQ/QUzH0eNg8bNyp35u0eikyipnlNl66Wa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158378; c=relaxed/simple;
	bh=TzD8vp/fFcQWDevcKiOpUZkuif8uCdmPLd/RTrWQETU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/OJrAakG3p1NodEOf+MkUa08vFBneEzoWCUKde0q2bq7CphC/m95yqblOawxC7QuuMFoEBSbBJr1AbI22SwzSfrGwJ+kFyXQwQeyrc7CKkgGmspQLijLMCNa8JzujiIBI081nyGJHXiqsg7w1vjExSXp25NtW9/0L9cOePSfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIZLnOuI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIZLnOuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A35EC2BCB2
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778158378;
	bh=TzD8vp/fFcQWDevcKiOpUZkuif8uCdmPLd/RTrWQETU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QIZLnOuIwUqz/chF8AK+rQ0qFgLgtz6aBTLD3usMET50aHOS+0t82DLhq4ufYnplf
	 u9LRf/+vZB9YME8ohcRTrYxuoWSzyscidVlMwvXSS/YKU4VE43oPPxdx5UWf7ZLktx
	 ZNmFK45HvVyba8H4gDASOtlqZDBQ0wCJzwuF1KJG9DovdHOvZL5wThC7LZ8fS4+KXM
	 91aodwkGYLM4118QYaL+cbF5GVRVZ4dHMhe3AEdRKifgcQ5qElxP59LgIWwovhPqnM
	 fb8hIthcCyguZ/VcEwGw1JBXcN5WhsMgNqzYIAhiUTE9M6pViFelh16Q3RFi0zox9Q
	 9e5DMIY034TDg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so1344743a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 05:52:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/DkqZQd1duph9W6WkhV5JS1hSlRoIn4c58UsjDERvwzcYk9veKEeLD3+NmCDGKMnhoL9exiR3lu7fNELJx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3AN3qu+Ed7PuvrdF+qgloX2YvXrYy0UoMmnk03mHhftbEQiFM
	Bue9MwX7eDdESeRJUho89IZJy3CiR2MLYyaQLre+oJ9zLlIzau1pVjCruDvngx3ixLVNC1rMevC
	Goe82vpID1+Z4RmV8IQu7RFslEt5as+w=
X-Received: by 2002:a05:6402:3250:b0:67c:5915:5a0c with SMTP id
 4fb4d7f45d1cf-67d642c93cemr2988285a12.19.1778158376826; Thu, 07 May 2026
 05:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504154851.3034915-1-charsyam@gmail.com> <20260506092448.521995-1-charsyam@gmail.com>
In-Reply-To: <20260506092448.521995-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 7 May 2026 21:52:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd84WV-CTR5mEFgEtyQjYEnX4WcNWFmnOgEmqJpAY9LOrA@mail.gmail.com>
X-Gm-Features: AVHnY4Kh7qNvxrVn1D7NpGCJg4WpueakPPXWhHpLlosL2PBJx2O0RhssR8MbLoc
Message-ID: <CAKYAXd84WV-CTR5mEFgEtyQjYEnX4WcNWFmnOgEmqJpAY9LOrA@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix out-of-bounds write in ntfs_rl_collapse_range()
 merge path
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 6:24=E2=80=AFPM DaeMyung Kang <charsyam@gmail.com> w=
rote:
>
> ntfs_rl_collapse_range() merges the run on the left of the collapsed
> region with the run on its right when they are contiguous. The contiguous
> check chooses a clamped index when @new_1st_cnt is 0:
>
>         i =3D new_1st_cnt =3D=3D 0 ? 1 : new_1st_cnt;
>         if (ntfs_rle_lcn_contiguous(&new_rl[i - 1], &new_rl[i])) {
>
> but the merge itself uses the unclamped value:
>
>         s_rl =3D &new_rl[new_1st_cnt - 1];
>         s_rl->length +=3D s_rl[1].length;
>
> When @new_1st_cnt is 0 this computes &new_rl[-1] and writes 8 bytes
> before the kvcalloc() runlist buffer. The path is reachable through
> fallocate(FALLOC_FL_COLLAPSE_RANGE) starting at vcn 0 against an
> attribute whose first run after the collapsed region and the following
> run are holes. In that case ntfs_rle_lcn_contiguous() returns true
> because both checked entries are LCN_HOLE, so the merge path is entered
> with @new_1st_cnt still 0. Such consecutive holes do not occur on a
> well-formed runlist (NTFS keeps runlists coalesced in memory), so this
> OOB path is only reachable from a crafted volume.
>
> A normal runlist has no element to the left of vcn 0, so the left/right
> merge is not valid when @new_1st_cnt is 0. Require @new_1st_cnt to be
> positive before checking or performing the merge. This skips the merge
> entirely in that case instead of clamping the merge target.
>
> The out-of-bounds write can corrupt an adjacent slab object. On a
> non-KASAN kernel, it is reachable after a crafted NTFS volume has been
> mounted read-write with the legacy fs/ntfs driver, by a local user that
> has write access to the crafted file.
>
> Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator=
")
> Suggested-by: Hyunchul Lee <hyc.lee@gmail.com>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Applied it to #ntfs-next.
Thanks!
