Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C21E3D8914
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449378; cv=pass; b=fACkVd9GkrQ4b7lNnkhhlEvcIX7evIr0N4hQ4REoHXqODxQGvBWXvgtfUmzMr1ickAfjyETQAbbKR0FfkalAhAFHDmwhblkz4ToF5ltD+ZeoTtO/iLSM5fK21ljt1Zp88EZIuFNjz73bT5F6EwTu68kWVAiq0NfIKykdJwRSDmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449378; c=relaxed/simple;
	bh=UOU6NkmohJFSfg1OF+MiKulURUXGBBB3Sz/k7DyNkxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ov99L1kye1dVokM2BVEA92JOzRBjaAlc5JVvDRleCslRlk9PFG5pvJR3fe2MMgp2yzd+39h4kpzzS0tBar22vAomrWDH6jw714DoXpb3hcMVRfSa3PKvUGWpmwNG4eL5kwdfGPcz04nydwBEdTZ82fDbMkCIhkhUuiEZWeNqrF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+TsODi1; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+TsODi1"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so504235a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 15:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785449376; cv=none;
        d=google.com; s=arc-20260327;
        b=G5U3d1UbxLOiuadlZ5n+DYR958qotWVf/4FGngGbX3iLnYvN9Esw0n7bNyFv0vDdTX
         YqMAY9Fec0ETU9MqLh0bPhRvkVuFoUbnX4JTVA/dZmKzmndARU0bF6reh+K4IzshjaI7
         miseyZEL6jNk1BgeTbsuUT6f5JA9jTCnMJZptZwjqLc5OID6bgf4VT3ek01znNdGnOCI
         QYWiSCS+IPIBZYSxcl96kdoPRHC674J6L+/LuhnNJrDRAY0EgzCBiWWJM/UBmzAcKasp
         Mp9POc7eJAIvhOSIKe6906Ot31ai0BIpbXH9y23FMWlFV/uFOze1M738DTtuDtDo4pl6
         zpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1sPl00gD5iNascBQucWd6PA3Csqt9a+EMSh1AoPbupY=;
        fh=YuOc4HfEykDDYQixVd6P/SQXaxH6igAM/GioEaAeUh0=;
        b=h0/uZ729zOk/2X+KeRNQh/XA6ncMJmOnvyRk1CXc7lZsWBuY6gP/M3D0La1z0zJqKL
         t106/ONZhkCbs2PdLDKNV1gQZGnHjfduv1ZRtmjbtlNdGuitqDCcjpTsBI/7dfaVK3u/
         W5XQyRKzw4T/aN4If1NEERNMAxOt9O2xZkkoaz5exWLaFMpVBZoFZFxHPmwc/ZcQiIHk
         AcXeDp/893fztWjoG/UXOgubOTHG+UdWVKZTzxuw1lMNQfEQ9kT29x6J28bx19bgF79o
         6u9ec8YzZ3vepZUNE/h6H07mUxtVoEY+cVNDYURd6MzsC0JlfhqEVxeq0hzJsbUUQskI
         e6Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785449376; x=1786054176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1sPl00gD5iNascBQucWd6PA3Csqt9a+EMSh1AoPbupY=;
        b=V+TsODi1ggypPAPta2+cCuGqUrjcDxkrxqaO0W4t56CkSC4xqhwIjjMGzumqO1Ewe/
         m3x63S/eBvKF233BPXiZXlCgfI749mQUasJjAWVbzn2xpCcwe9ebfQeBCHLz93wTOZ36
         j2/QVvDJqwSFlaCX3RWB7TRYNh+DmgtKEDRknSzVFodPuxBO70S9rLiVTgStayCzR6hQ
         aP28CJ0qwMnKQdGpNE1NrEmHmWlfWeMc4hs+njvc7w2jXwilQWXTmxVAcEv1xuMnUA0D
         +JmKpAncatLil6JVO7DsQC53QmB4hYVH75yw5VmOA3wlK2IvEfTepF4JRg7Op7lIDIHy
         /PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785449376; x=1786054176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1sPl00gD5iNascBQucWd6PA3Csqt9a+EMSh1AoPbupY=;
        b=JsCqOT3gpTuc348lmf3H6etO0mVugH/3J3iA2twXfZATrlSmkaQ1RFwf1bmrwphWNU
         fgDrvdgW8oisZvzGjTI8UAvGjA8sFjTkmUi+lA3DCh+2NIgsZu+YX4Lv90gfM56oHocY
         ra6KIRX6/Vdy20PStbJZ69pib1kHpXHUPoo2hfFfLbVQ+pY6rn9YT5TxRhU/d6ysvRbr
         5c48h/e7EY3DCXiJjKtBeQmUUqwETfCtQf6D0W86wIAn2zdt6sahg723uTTIaa7fzGEw
         6pKHFm7wJi1+e+U67ZZUOmvNqYsCFXlim95HIA05w4Uzh5Vytdiun1+W7Kp0Kz30CD45
         HAag==
X-Forwarded-Encrypted: i=1; AHgh+Rqnb/pU436+DdhKofzSZjejjfsHi6R8cCA/irX9XcPscR5EYrICYICg8ol8z/JC3QDpp0kyqwcXWH+ak6t0@vger.kernel.org
X-Gm-Message-State: AOJu0YzbF1Z22EK3wh/moqif279xkbvzPtDCOEOtL34oHjxYc1oODTAv
	JPmpKs9HXsjjUlQ92UX3gn44TieP5FbDHLY4NwmIG1Z50XvQ3I+mqtZdg05gi/29+rYgM+oXuzy
	LVIHg080CwjvzlK7sAG5CbyblCLK/TtA=
X-Gm-Gg: AR+sD11+thoI9+ErqA3/JTbMv0qZQbC8b8M4Gnr6J+dWsTo/2rLRCYI+Lw3JDe5K6YG
	0gOu1uFs9iJOX8fNxOVe+44DE+3idDj1UGkaulnpnMXwJxcVzAvJwlz7dWc9pkXT9SHnIrhrRyb
	g19fI/vNGDyojmz3KCyu9r/hkCfEqPA+f2lFf9h60ZFsGWkso5w+gz7X/YgFYg6aCO3Nt3nUDwg
	VbSBsMgq//+GMOHo30qybmPz8zpI0tDhM5aIbZvX2tx526wE0vYL+ahOimfr87+ySt3oG8KFtwX
	q2aBIiL2Y+mWXZwCTJ0iTHbe9JYeP6EEFCRNRIp0glzS
X-Received: by 2002:a05:6402:510b:b0:6a0:5f42:a169 with SMTP id
 4fb4d7f45d1cf-6a07b87205emr2142876a12.34.1785449375450; Thu, 30 Jul 2026
 15:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430053645.1466196-1-coshi036@gmail.com> <xaqwfkwjnp7h2lg7ir6wy2tnyay26t3im3ftkdl64rhys3rhmu@lc5vfh5tc2f5>
 <CACd_6n17-pJuNoCLsstP7goocedrr5F8T8BwTjRUNx8frKEPgA@mail.gmail.com>
 <bnchcfog427eo3bxt5h6qautlq7sb2o4ww7cjgad73biycdn5f@np7qkbyqizup>
 <CACd_6n1Sht4xs6P_GT0-+wj1uu9Ww_4X=TysQRvq6ZSFJ71CBQ@mail.gmail.com> <amuyCIg0Y1YRiFT7@casper.infradead.org>
In-Reply-To: <amuyCIg0Y1YRiFT7@casper.infradead.org>
From: Chris S <coshi036@gmail.com>
Date: Thu, 30 Jul 2026 18:09:24 -0400
X-Gm-Features: AUfX_mwhzbgq1GvwUsSWf4ISXvfMeXBv1LaND2dwm5XXQzJvPmz-MJ-e6MYbmgA
Message-ID: <CACd_6n3C1btK38SdwiG_RPdxxCQ2qUtp4o-aODhhRzH3LNn+yA@mail.gmail.com>
Subject: Re: [PATCH v2] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, that works. And appreciate your reply.
  I prototyped it, and it survives a journal replay.

Six sites, with bio_add_virt_nofail() covering the submit side:

  bh_offset()                     b_page may be NULL
  buffer_set_crypto_ctx()         NULL guard
  __bh_submit()                   bio_add_virt_nofail() when !b_folio, and
                                  skip wbc_account_cgroup_owner()
  jbd2_journal_write_metadata_buffer()
                                  b_folio =3D NULL, b_data =3D
                                  jh->b_frozen_data, not folio_set_bh()
  jbd2_checksum_data(), jbd2_block_tag_csum_set()   both kmap the temp bh
                                  (fs/jbd2/commit.c:705 and :745)

4 files, +38/-12.  I'll send it as the first patch of the series.

Tested: ext4 with metadata_csum, mounted data=3Djournal,journal_checksum,
writing files whose every block starts with the JBD2 magic so escaping
forces copy-out into b_frozen_data, plus repeated modification of the same
metadata while commits run.  Then sysrq-b without unmounting, reboot,
mount to replay. Journal recovery completed, md5sums of the escaped files
matched, e2fsck -fn clean, no warnings.  An instrumented build confirmed
the b_folio =3D=3D NULL path was actually taken rather than silently skippe=
d.

Best=EF=BC=8C
Chao

On Thu, Jul 30, 2026 at 4:20=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Jul 30, 2026 at 03:47:23PM -0400, Chris S wrote:
> > Hi Jan, I'm currently working on the changes we discussed.  Based on
> > vfs.all now.  Four things came out of writing it that I would rather
> > resolve before posting.
> >
> > 1. mark_buffer_write_io_error() is not safe for jbd2's buffers yet.  It
> > dereferences bh->b_folio->mapping directly (fs/buffer.c:1057), and
> > jbd2_journal_write_metadata_buffer() points the temporary bh at
> > virt_to_folio(jh->b_frozen_data), which is slab-backed.
>
> ... yeah.  That's one of the unclean things which keeps me awake at
> night.  Sorry you ran into it.
>
> My longterm plan for this particular usecase (pointing a bh at slab
> memory) is to have bh->b_folio =3D NULL, bh->b_data =3D (address of data)=
.
> Maybe we could do that now?  That would make mark_buffer_write_io_error()
> work without change today.
>
> There might be a good reason I didn't do that yet, but I forget what it
> was.
>
