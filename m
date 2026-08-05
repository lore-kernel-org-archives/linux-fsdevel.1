Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8F3DC4BD
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962009; cv=pass; b=s6bIIW7CqYeRlf2gACRDDafsvBczHhRwDCkhphOCyFfRgFMML70uaxHO8Y/Xyv6kMCZbho7Sn9auW9Pa4vo4cbaSTrs0jnDD920BZmxFl/ayMZVf555+eHfuWrBoD4AI5OqGJIKAiZPH0E0zwR/vEURmtZ8pdQokiDYt+xoVONA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962009; c=relaxed/simple;
	bh=GI8C7x7/1X74WCp4xq6Tj+lGkjg4R7DvkuG6i1NAga4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLXlwlfv5LoIDD3OjzfRudaOA6RC02igZ58SVhmW3VnbfskSfmNBw9lB/tte9gYJTrbzTaLXf3Js1ihpSKB/iF/i9/jj0Loc/HCmHQY0aSq3Z3kekg/3DOkrFwflPHuZpDBTY1FQtadUAEwYn5ahw/ee1jA3R0VCT0lEePDSUS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYM5++qn; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYM5++qn"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4a416619cb2so971469b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2026 13:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785962007; cv=none;
        d=google.com; s=arc-20260327;
        b=ctX5GON7SZ2o7gJbGx/IBEY/wIDYitvAWMLgXc6U64nAbdJTBDG+6y9uWW33dM08IJ
         eWIKRiFg5dxf8m650bHgEFCkfNgMGHB57kJblCm/L+FwUxmoIwG1Udi/OhzjLayWZf4r
         +YsmdwCNgyNP1wwtRUrP5l2p93kzTOUUFoVkiapPAaKvfse09SMIUSMrcM/dxLrg9Smj
         e+fhbMKpL8lGIRyUJ3ljGPvy+NeYjvgPH6isCV8A0LdWswKxskMfl0jayu+lumfTz2Fi
         7NbpgYforfOfUaeYYx+vaPYISWpK6AbrQQ6nmCku3N0MHNfClcbZZHTsY309yO1YINRf
         rZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WXwiR/pZJKH9ofJG0kWfM6Ol7KNG5CJwWwWByT6iJt0=;
        fh=5FSX6WeTd7FaMWrmIAHXVqq33cQiTMcgkx+mcvqEnf8=;
        b=QGZFV8yu/6Q/tUpSRYVxYzIA/M9S4VmrNiD+ohNns5CyppxcdF80mYpUvR9sFxOER7
         ygrR/TtSoHbDs5Rf4o2fsU4dxKbtfjD5sA3A9ZosQqGya1GYCsO43MH+vU7WViyOf31h
         hdh8MwmBGVl0h55c/eegZLNtqtAOiSJLnV9yKmP+5O0d3x9SdetM8ewNawKN9Q88Vzf0
         RIQL4DLxg9iNjIXeO40pEqObxWJUzlW2wbCc7sTzaMA/neCUzHrzZf/YB6o68d9PeBzF
         gS/kSoEia/3B+Nxc8ctOk4HjGi2u0odCugVtxAzvg77REECLImPDjb80qb4ExJtVsFti
         8vBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785962007; x=1786566807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WXwiR/pZJKH9ofJG0kWfM6Ol7KNG5CJwWwWByT6iJt0=;
        b=aYM5++qnVdT9bfIO5aB0eePb9McpaykzDiuPLfQxhlGUlivEpySUYafw5hMLinOfnw
         Xe9pRp6mBT/hxACGT441bcN8w2FpcMgAcm+KrEc2lH0ywRmYBz1Is21ArEd9zVj7Ix6I
         i3w1tm9Hs7J1TXHl6AbEUGT4nRx7MXuisr8xRPe/QDXT86f9Fp0/VBc0iatLMzc8D6ba
         OFgWVBfcLUdzQK7JlKy0V929n6zPjfD4N0Iudev6fL+VjmdonU85ywyDNiK11G53sSku
         StpcG9SuYGaY1ZbpFJoBbJUc94umdLAiCTf6Ifmn3uTDUraw0cvrmyXLggUw6CC6H0c4
         5kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785962007; x=1786566807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXwiR/pZJKH9ofJG0kWfM6Ol7KNG5CJwWwWByT6iJt0=;
        b=lheiGEo+Iq+UGHa8Wx/C1rWZNwk7mokY7S2Qypd1wZS+SxY6DT8SsEYh/iNMGnlzps
         Zfobj0KKeIse/75zDBZ/LZ7l3Ep5E6EAas3lAoWoEN3WacSFFsyI3lj6w0+j3XI5Ink7
         L2+fXSrPGB8w42LN3zL5XGmeivjtoQMQR0sPlP3rjMjGbRO6eLErqxDeTXmTuE3QgBqU
         2MUE93/qF/UBOJMdiJvnAAkpJBkY7IJaxqoN+91L0dkX/lzIHX10KoH1b3G60yN9aktT
         +hWUEE48QFKFLcZsby6m76/dwO1vo68Sm4keOglK2GJFdT2A2x2fZr4MDhdEjuR/Cj8D
         Gaag==
X-Forwarded-Encrypted: i=1; AHgh+Rr6EeEe8HBFhOOAtx+pOSHh/BvQKnL7/K5jPUOGHMkDak3qj465czOs5kaxCs+bWAuJOEvNQZsU4fx5Lq8k@vger.kernel.org
X-Gm-Message-State: AOJu0YzKBL95F7SYLbUQAStii8sBsOOdjHVOIW04r4/4vetHCTDGKn29
	g8LSBzF0rKDDVXX4GFuHFRwAX71YVQm/nnjodzx3tsjKS7DcXtvORlp5kJ1s5JFuJvHt6Dglu6u
	sQn2mz1sPSTAuO//1Xe9e3JEzO96P75M=
X-Gm-Gg: AR+sD13KlO6KCdDPT8RjllLBGDOpj4tcnDLCP3F1qsZ52hjwHiV9QftS7m9bnzaGoBr
	gDbK3y4n8WOtVMUzvUB+O95iV0DnjgY9OQuram6wdnm3bY9Q6BpCyd+pDhMfJBm0r/0YM7MfeUM
	TT897eKG3mscmYCYlL9cea9uFMY+/MSizfFt78JE80s77MSPFUvrKSw8ZsXYUAm0C8zwhjRRyGw
	PEPVig47WQOyiwI8BKyPHlMsNt5L3SaEhDmgQSwn2ei9sF599hwnScVBGSweWPy8OnB/nGUPrOD
	kwlAwwr6TudQhwWcI8SLXmZLGwdT1sYdlmU+kSdX9Nv/
X-Received: by 2002:a05:6820:4b8e:b0:6a1:4a27:cd22 with SMTP id
 006d021491bc7-6ae968d0ddbmr5568777eaf.0.1785962002030; Wed, 05 Aug 2026
 13:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785621505.git.coshi036@gmail.com> <f0e0fd8516487b774d8cf1384949a0c616921fbd.1785621505.git.coshi036@gmail.com>
 <ppnbgcljrjb5wqqvqiyh254wkunfutydykgbi7zheuf2mfdjqv@j6lngn5vywxj> <7qfbpj66hdtxc23lox63hqss42yo5xz2dazigf7nwdorplmec5@vv6jsnqa6viu>
In-Reply-To: <7qfbpj66hdtxc23lox63hqss42yo5xz2dazigf7nwdorplmec5@vv6jsnqa6viu>
From: Chris S <coshi036@gmail.com>
Date: Wed, 5 Aug 2026 16:33:07 -0400
X-Gm-Features: AUfX_mwz8K3T1Z_fWdMufWIMTQu1kthOhf45o3aWABfKf2Yu8afHwh21AjQl4bU
Message-ID: <CACd_6n2fBNVQF3UXth_WxGWHMLm7SysDbcQ3PrJc32nDfpMwCQ@mail.gmail.com>
Subject: Re: [PATCH 16/19] jbd2: report journal write errors with BH_Write_EIO
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, 
	Bob Copeland <me@bobcopeland.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-ext4@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, gfs2@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Done in v2, and 'success' it is - thanks for the follow-up, that is what
fs/buffer.c calls it.

        if (!success)
                   mark_buffer_write_io_error(bh);

Patch 21 adds a clear_buffer_write_io_error() to the success side, so the
final shape has both arms again, but nothing touches BH_Uptodate either way=
.

Best,
Chao

On Tue, Aug 4, 2026 at 5:10=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 04-08-26 10:54:37, Jan Kara wrote:
> > On Sat 01-08-26 18:01:00, Chao Shi wrote:
> > > The journal's own write completion handler,
> > > journal_end_buffer_io_sync(), reports a failed write by clearing
> > > BH_Uptodate, and the three places that wait for journal writes look f=
or
> > > that.  This series is removing that convention: a buffer whose write =
failed
> > > still holds the data that was supposed to reach the disk, and saying =
it is
> > > not up to date makes callers rewrite, re-read or WARN over data that =
was
> > > never wrong.
> > >
> > > Set BH_Write_EIO instead, with mark_buffer_write_io_error(), and test=
 it in
> > > journal_wait_on_commit_record() and in the two commit-phase waits.
> > >
> > > The two changes have to go together, because commit phase 4 waits on =
a
> > > mixed list: descriptor blocks are submitted with
> > > journal_end_buffer_io_sync(), while revoke blocks go through
> > > write_dirty_buffer() and land in bh_end_write().  bh_end_write() alre=
ady
> > > sets BH_Write_EIO, so converting the consumer alone would keep workin=
g for
> > > revoke blocks and silently stop detecting failed descriptor writes.  =
With
> > > the handler converted, both halves of the list report the same way.
> > >
> > > mark_buffer_write_io_error() is safe on all of these buffers.  The sh=
adow
> > > buffers from jbd2_journal_write_metadata_buffer() have no folio and n=
o
> > > associated mapping, so it does nothing beyond setting the flag.  Desc=
riptor
> > > and commit blocks are ordinary buffers on the journal device, and mar=
king
> > > the journal's mapping with the error is what write_dirty_buffer() alr=
eady
> > > does for revoke blocks on the same device.
> > >
> > > Signed-off-by: Chao Shi <coshi036@gmail.com>
> > > ---
> > >  fs/jbd2/commit.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> > > index 60273cddf434..8912786ebebb 100644
> > > --- a/fs/jbd2/commit.c
> > > +++ b/fs/jbd2/commit.c
> > > @@ -39,7 +39,7 @@ static void journal_end_buffer_io_sync(struct bio *=
bio)
> > >     if (uptodate)
> > >             set_buffer_uptodate(bh);
> > >     else
> > > -           clear_buffer_uptodate(bh);
> > > +           mark_buffer_write_io_error(bh);
> >
> > There's no need to set uptodate flag here at all (all callers set it be=
fore
> > submitting IO). So you can just simplify this to:
> >
> >       if (!uptodate)
> >               mark_buffer_write_io_error(bh);
> >
> > Also I'd rename the local variable from 'uptodate' to 'ioerr' or someth=
ing
> > like that.
>
> Sorry, not 'ioerr' but rather 'success'. I can see fs/buffer.c names it l=
ike
> that.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
