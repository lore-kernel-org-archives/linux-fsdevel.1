Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C03C3C0F
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927628; cv=none; b=Uo7Gpf21dRHVC23tMOioO7HINHw0xgTDu9+Ws9TVW0G9Fu9CmXdNGwlKMs39Bpb45YSi31vurcmXT+PCaeA7R8OSP4gOQR8aQd8fk3wHrR5k+LkRrYs2ue3Jrh8VGtxkfVMDCawoRrLuKQkuRIPaV8DVIcFjW8KJE8VaI/KUoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927628; c=relaxed/simple;
	bh=7jlzMzl44EANSvFzmH/zCJiewBdpmtLdT2IXLhloPCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHy1iIw3/J7SlFBCuAPOJTI/+abEgZ57qlvFlLwKicS5kLHqVp7dgzvmoIjSXp4E5mElb9GIfOyNrrz7YFwRBcsPUg4axKHMPBcQMe51utT18s5Z9mNyxVaVMSSFyz1UpNQIO6SfDq1V8BFe6TD0O1rVl9xPucr+ElOfi7tPePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+aOjAl/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+aOjAl/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E751F00898
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 14:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780927626;
	bh=7jlzMzl44EANSvFzmH/zCJiewBdpmtLdT2IXLhloPCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=F+aOjAl/EzP+PYgxNKbXwHPlH6bHDXBpovx2v4iPOi25ivb5exH/ki+jBrra6LHVg
	 CwL8PQAPZVcxL4j8i0zpiBltTlfBt2Qi1cyvI/vs7bD6KwWpbOM1x9vjQTrPK/p6sr
	 4XcrAygZYEDsnb3f/a0NKUT4SMszl/RHxFE2I9jI6lR/urtYdmrC6jCtXRhbZjL4KJ
	 n2fyrzYPT/N9qLEa7WqLVS6J0/vLjtMarpD+Rf221ZDoMcWQIWsYTNmgCQBORhrDzH
	 xcGMSJHKwzUzdaRT2T4Z3xaVWljKFVe2bhwhsaA8UcUPiW2/f4c0IUKH9+tTyJeYOT
	 Y3o1E49rTF8DQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-691b0090cc5so2394448a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 07:07:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9kjwT8e/OdtmSD7gOPG+900fGAXVZ/HcWIJLsq+l7opNkcVLuFguLZ9OzyVyuMuqKAQVxOuZt4qX3KUDYq@vger.kernel.org
X-Gm-Message-State: AOJu0YyNLb+q0Icb+xelT4vcGaEsZoPMkgVpwgXAe0Svs2xQbK9CvH4W
	YXGEEF9+fB4USh6ajHbwpxO1KelNpKJN9vqux2E4iNOVtOu6qwbqtc4ag+N2FMxwwb7dswtChxz
	ghSVu3x421chFnvScS/SZRn7eyFcflAk=
X-Received: by 2002:a17:907:1c85:b0:bec:7066:8439 with SMTP id
 a640c23a62f3a-bf370a663d5mr802397966b.18.1780927625264; Mon, 08 Jun 2026
 07:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607203000.700100-1-hexlabsecurity@proton.me>
In-Reply-To: <20260607203000.700100-1-hexlabsecurity@proton.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 8 Jun 2026 23:06:53 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9nRcxdDBzJwVGS8+YryPzjmv-bKGp5D84zsWruhUB04w@mail.gmail.com>
X-Gm-Features: AVVi8Cey0K2pGQB8JOcxtMKUk36M6itPDFyAJoFRoHcHnMbLD4PvrngU--9-mY0
Message-ID: <CAKYAXd9nRcxdDBzJwVGS8+YryPzjmv-bKGp5D84zsWruhUB04w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ntfs: validate resident attribute lists and harden
 the validator
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 10:51=E2=80=AFAM Bryam Vargas <hexlabsecurity@proton=
.me> wrote:
>
> A base inode's $ATTRIBUTE_LIST is sanity-checked by load_attribute_list()
> only on the non-resident path; ntfs_read_locked_inode() copies a *residen=
t*
> attribute list into ni->attr_list with a plain memcpy() and no validation
> at all. Every subsequent walk of ni->attr_list --
> ntfs_external_attr_find(), ntfs_inode_attach_all_extents() and
> ntfs_attrlist_need() -- then trusts the entries are well-formed and reads
> attr_list_entry fixed-header fields
> (lowest_vcn at offset 8, mft_reference at offset 16, and the name) with
> bounds that assume validation already happened. A crafted resident
> attribute list therefore reaches those walks unvalidated and can drive
> out-of-bounds reads of the attribute-list buffer.
>
> load_attribute_list() itself reads ale->name_offset (offset 7),
> ale->mft_reference (offset 16) and the name length under only an
> "al < al_start + size" bound, so its own validation loop can over-read th=
e
> fixed header of a truncated trailing entry by a few bytes.
>
> Factor the per-entry validation into ntfs_attr_list_entry_is_valid(),
> which requires each entry's fixed header (offsetof(struct
> attr_list_entry, name)) to be in range before any field is dereferenced,
> that ale->length is a multiple of 8 covering the fixed header plus the
> name, and that the entry is in use and carries a live MFT reference.
> ntfs_attr_list_is_valid() walks the buffer with it and checks the entries
> tile it exactly. Use the list validator in load_attribute_list()
> (replacing the open-coded loop, closing its own over-read) and on the
> resident path in ntfs_read_locked_inode() (which previously skipped
> validation entirely); patches 2/3 reuse the per-entry helper at the other
> two attribute-list walks.
>
> Fixes: 1e9ea7e04472 ("Revert "fs: Remove NTFS classic"")
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Applied 3 patches to #ntfs-next.
Thanks!
