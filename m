Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E794071F6;
	Sun,  7 Jun 2026 01:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780795117; cv=none; b=Wh/Kwpx60H5DyIp/Nh1UZ2BWbBsYcx/JabPf3a1wmUYgHhK/NJ+01YxlnqAbKElNFOsriMoEQWtl6WCLszkZIecuUFumdJsw49sJASGYVGfhvO989wRzyLsbjXxabvIJgsAamEoL/zSS/GPxxmhLBsNlfh7CqTQEWStCcxcV+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780795117; c=relaxed/simple;
	bh=MuZGlztn9wViw2Lfnw5ck9P6+LK409dRvmtAP48lbg8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3//FOeasBXv2q2vOwIQbrBdGf3CrFe5FQn9AnRTeUfICqiIEhaZvNGRYjDzu5GL/9wMKJR7h9Iy/8fSHlryZ3xS050FB9JfBhx38B42ZnfT4P0IhWlIi69MugwQeT5bjQ95afBH37UHkPX/pp48xsfQ64uB/SRDFe43UBuNfsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KQh+kZJ9; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KQh+kZJ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780795106; x=1781054306;
	bh=MuZGlztn9wViw2Lfnw5ck9P6+LK409dRvmtAP48lbg8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KQh+kZJ9au8336CdQ8MCojjlSC3+kmVmRGUxu3nesWBFaz2240WIChwLdtWSlI0Ea
	 fbH1yq59rgLz1ZxVvnISXULkzIY+1bhp4W2Q0mfrrX9N3VQqVTGWH1BLXPAbFugYYR
	 lyIWPS2KA1z5hWHJHXuHtm+4dCBHIfFcIH3TegIWJaX7fRg/5SwtsqbjgA99pctBzE
	 WHWxUq2Dh3wv2/58JzS7bpeP+vBpi/ynP0H4SGnFyfvuCuioLapDSdGIjZA3UCbJ1L
	 WxsAlbVheNJVNHIr4AvhSgsSHfsHHd+QTMKEeLvqQ2aw9AQ35Cb4PD4DNX86mEEwwi
	 aoNhtuIFj7S+g==
Date: Sun, 07 Jun 2026 01:18:22 +0000
To: Michael Bommarito <michael.bommarito@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: bound Rock Ridge symlink components to the SL record
Message-ID: <20260607011817.217712-1-hexlabsecurity@proton.me>
In-Reply-To: <CAJJ9bXzdj6Xxa6wXApV_TtCni1sgEryHmV+=iy8yECGNYeMSvw@mail.gmail.com>
References: <20260606222857.193818-1-hexlabsecurity@proton.me> <CAJJ9bXzdj6Xxa6wXApV_TtCni1sgEryHmV+=iy8yECGNYeMSvw@mail.gmail.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: faf46714b14c6d8f9d13336b4e6fe1561687f951
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 6 Jun 2026, Michael Bommarito <michael.bommarito@gmail.com> wrote:
> one note I'd mention is that I returned NULL here instead of breaking so
> that readlink() would fail with -EIO downstream. Maybe I'm missing
> something elsewhere, but I think this design results in silent truncation
> and a potentially confused caller who thinks the symlink was successful.

Agreed. In get_symlink_chunk() a break leaves rock_ridge_symlink_read_folio=
()
with rpnt !=3D link, which it treats as success, so readlink() returns the
truncated target. v2 returns NULL there instead -- matching the existing
plimit-overflow checks in the same function -- so a malformed SL record now
fails with -EIO rather than silently truncating.

I left the break in parse_rock_ridge_inode_internal(): that site only bound=
s
the i_size walk, and the link is read back through get_symlink_chunk(), whi=
ch
now errors on the same record, so the truncated i_size is never consumed. I=
'm
happy to make that site a hard error too if you'd rather both reject.

I checked the three behaviours on the exact loop, with one valid component
followed by an over-long one: unpatched -> 255-byte out-of-bounds read; bre=
ak
-> readlink() returns the truncated "abc/"; return NULL -> -EIO; a well-for=
med
link is unaffected.

v2 below, with your suggestion.

Bryam

