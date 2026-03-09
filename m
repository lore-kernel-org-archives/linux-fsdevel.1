Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED463BA24D
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 23:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773098906; cv=none; b=n/p1jk12a7U+ZPEYt3xaobdVHhBkL0+OpLh3dEo2hhvUABC7NzR3DYPfGIIdtMt7ZGwyF0n3zeYiwhpF5VNT+EMDNPRwWITEO69EaNoYmP5n7BhpsTpXFaSERcQyk2acvsMbXq1oIGsgUnhxYEIbcAvploEIGhKqaUVeCmNhttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773098906; c=relaxed/simple;
	bh=4ksMIesX7IAnVe6f/RIMPAw6ttbJkaebju8W2cwjeOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJJAYaQ9d2VRIawVsBPygAdd7zGMR7Z+wkFg8BlUe6r7dDGC8BKK4JkdnEbdAxHWDn4wBGAixZBWiz7OV80LqoJd+s+j866ZYZ1u872ha59dgqdl8nlzGjCy7q6AK8CS+YbAwAVuPH/4ltPdByS9XJxh0NY/W7rO4hmCpnYqOFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaagYgMz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaagYgMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B63C4CEF7
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 23:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773098905;
	bh=4ksMIesX7IAnVe6f/RIMPAw6ttbJkaebju8W2cwjeOE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SaagYgMzseH0v2QhrrHHFK4t3X9DgRRey+uQpjYEHdoHLhLySmWMK/LiDckRe2DbH
	 +jToB/LatqyftRVZhob7rAMO9K12byI5V/fXcPBYHP8b2cePopaY4LcEHqAqXYc5+T
	 m9plwcu1038JL9a558bX254RO6oBAPwd0NWD19rxca520xW31g3jkCzSPMUzcP/Gd8
	 wnMN4QyZKff4i4g5/c8ea8LBroL/0dKmjI2TXSNtLsJGy6v1N6RmlB+/UCZjzVjJ6l
	 W6wuVVUDWaKXrdpPDra88KFEOLhOgYx11XOW8oG/mU1NR77RiGlxHWa8DTkQbiecUr
	 PzCNRJY6rrqfw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b96e9c59339so317720566b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 16:28:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YzBshy0AZ0gQbUbYmVa6P5GBxJjxPVt6Y8hYZUinCTd6YXorEyO
	Gyc6qTkxP3SA9T/JMy5V20AqmTKUP8qyER1BPITNIV3+4hTcfXxnuLBWdD6L4pSNLk5WKRsPh6j
	Jj/58KlrVnnJ2anljMgcREtP6LD0A1lU=
X-Received: by 2002:a17:906:6a0a:b0:b88:5953:2f14 with SMTP id
 a640c23a62f3a-b942db8bcf7mr706067566b.16.1773098904469; Mon, 09 Mar 2026
 16:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYAXd_8vG6V0NRT_kb76n_yo+d9vvcx6JZbMARC5+C1ovboqw@mail.gmail.com>
 <20260304141713.533168-1-dxdt@dev.snart.me> <20260304141713.533168-2-dxdt@dev.snart.me>
 <CAKYAXd_RiCKF1nJK_Jg385VeGxeOUo08s0a_SNgtty2508wDmg@mail.gmail.com> <72446d20-f3ae-4acc-86cc-bd8fa3d86f41@dev.snart.me>
In-Reply-To: <72446d20-f3ae-4acc-86cc-bd8fa3d86f41@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 10 Mar 2026 08:28:12 +0900
X-Gmail-Original-Message-ID: <CAKYAXd97EDFy1yeF=MB0Pc5hR3UTF_u9h=58F6pW6c61DGeWuA@mail.gmail.com>
X-Gm-Features: AaiRm53ozuEHUpHIhfduwkF2baDnw4rN3KPs7KHwpITUuu7rV_RkVLdB8VfZpQA
Message-ID: <CAKYAXd97EDFy1yeF=MB0Pc5hR3UTF_u9h=58F6pW6c61DGeWuA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] exfat: EXFAT_IOC_GET_VALID_DATA ioctl
To: David Timber <dxdt@dev.snart.me>
Cc: linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 5:05=E2=80=AFPM David Timber <dxdt@dev.snart.me> wro=
te:
>
> > What do you think about having its own
> > dedicated magic number (e.g., EXFAT_IOCTL_MAGIC : 0xEF) for
> > exFAT-specific extensions?
> Absolutely. I was expecting this discusstion about the ioctl magic.
>
> https://lwn.net/Articles/897202/
>
> My intuition was that the 16-bit namespace is already quite crowded
> hence my initial decision to add to the existing FAT magic. If the new
> magic could be afforded, that's definitely the right way forward.
> However, the ioctl namespace is becoming a scarce commodity in Linux.
> (ex)FAT is a simple filesystem by design, so there's not a whole lot to
> it. Perhaps it doesn't really deserve its own ioctl magic. I'd like to
> leave it up to the skillful maintainers.
>
> FYI, the room to grow(TODO) for exFAT/NTFS on my list include(somewhat
> related to the topic, not in particular order):
Sounds great:)
>
> 1. FIEMAP support for 512-bytes-per-sector flash memory drives with
> capacities over 2TB(512 * 2^32). Don't worry - exFAT works fine with 4k
> advanced format and > 2TB 512B LBA. This is only for filefrag report
Since we can find out the unwritten area through fiemap ioctl(i.e. if
fiemap ioctl is supported), wouldn't vdl ioctl be unnecessary?

> 2. VDL in NTFS. Although different in on-disk format, the behaviour
> apparent to userspace is identical (share the ioctl?)
> 3. exFAT/NTFS fs-level encryption(EFS, similar to Ext4 encryption) which
> may require a set of ioctls for key management - if allowed, that is(EFS
> could be patent/licence protected)
> 4. bad cluster tagging(offline or online) and some ioctl facilities to
> query info about bad clusters
>
> I'd say, exFAT and NTFS specs are designed maintained by the same
> organisation and that often leads to new filesystem features ending up
> similar or almost identical. So, yes, assign a new magic but maybe share
> it between exFAT and NTFS, if that doesn't break any rules I'm not aware =
of.
Okay, And if we allocate new ioctl number for this, we need to update
Documentation/userspace-api/ioctl/ioctl-number.rst

Thanks.
>
> Davo
