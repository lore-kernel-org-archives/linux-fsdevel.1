Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A232E736E
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707899; cv=pass; b=tQ+PS47VGTp5cjkqif7XtQAfWqIn2qwH5OpSQQMoC6YZM/IfP9RN1rdQswMWrbqzKvPRwP722LANy3g0OfXoMAE3UmujtWqrpdqqNFXZATCT6aQCc5YYmRDCnzCJgFQcIa7BNKK70u2LIgYTh5UC0plX3QyB3OAmyKKuR52P7Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707899; c=relaxed/simple;
	bh=dAUxks8+/THss1eLO/4QpULUCgYH/OZWeVxrIpVcei4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSCm/JrQ0X5+DlMiWfTpucghtbi0uqYGjMovAoXgvAxNq0l12qT8BV92w/ElL88TCb0BmStH2/Yt//JCDGR5bQG7DeivB8v1fIdA9/ivM74cW4mOdByeAPfaaF3RjYQb/sYtnHBo4BAnylINZer1SuOOLwNvVVJILQ/U6T9/Yw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZBA/Kat; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZBA/Kat"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so771491866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 07:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781707897; cv=none;
        d=google.com; s=arc-20240605;
        b=RADTnSxHQ0khjUqhQNu4jU83KuQ+T68S6ij8XKtQQH/d/aHuNyP2DUa312PSe5hfwP
         Bty2gt0FbanaDxjrAFxDW/IE2ElgfURjx0KLfhRksa1/NCHyrF6Rkn6f105SQS8pd1/L
         umkaVkuig/QEFeHqAmHr0gILWOLirfLd3FmwDmndwooCZG+8jY4uzuNpSJl57+oPSVJt
         xSQVMV7RZFyRC0p7vXeKlZWmqoE76myUeHpEqUxsmb0JgBc9j89ZzcID6d6BUtZAOw+2
         PtSYcV00lppS8LBdNO0vRd3bOSgjL1C27/DjbTbv8QjtHU8WcdFLm8L42NJZlJYVtQxc
         FNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ft/RyTCuIhbE3h1/qg2sqDYeE/BKsF6PlyUpOWFeyS4=;
        fh=8xJVd+dZfrX3JvDqkJhfa4hC851jzmAm9Ya81QEubqU=;
        b=hp28D89WFX3Arsecyn0tFU+xrB+CFfXnrnOMz28Us3o2XJiFAms0yancNE3ZrrPVy8
         3IkP9WbPuGB/tnIP/cdWSS+pZuylKXDPfgKCv9W5FL1+8FbSo9dY5ru0jsCXlJRsQQuY
         /32m+WsjbtpWi6g6fWvaJGe+PW8OJV965GbL9Y1hYWpcUeEnTkrav/I8WxCyN4WzfKJF
         jxIhZLinbAglqTv/jvLWkT6dJcdcE17EIk14BHkDAQcpj95fMDZ+qTTfhE9h+mRcLmHw
         YArkvm9OknfV5qboDPlzncO2pSnEsNC9uQ7Z9vaIC1h8ut0/+YxbLDkuuxegMHQg02Ss
         /Fww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781707897; x=1782312697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ft/RyTCuIhbE3h1/qg2sqDYeE/BKsF6PlyUpOWFeyS4=;
        b=QZBA/Kat9q1pyFt+b3YaVcs98MoIsam6pC35UC2Cgson3H+lP24nZGdyT5s4bAjPSp
         QuyFPe4J2tm2b0cYW3NTL+TW+LVjyTYozhGl9NR07FVsCHaY9rIpk4EM6/WnbDJiKXEt
         eJvhUhpx0I61cuhNx4dbbEM8vYEkXdCXAQ188LAhXjZj/u46B6olwpHQdmh/Q2MYDjb0
         HLcfpwCX5asqHwoXPtNuJfSXBL7JIqSmX6zbHwcBBcZYPTj7AK2JKSF3QY4+oCSecYwz
         qBKKIS0WGj50ByXR/QNs+7JHWg8gl9SlawoiT1d/oO3yUovy50N9GgvT19+nJEyryhIX
         VSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707897; x=1782312697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ft/RyTCuIhbE3h1/qg2sqDYeE/BKsF6PlyUpOWFeyS4=;
        b=lQ/MECeHZ3d6Rr9WqHvHmDddr8l6XBjvc1AmOv3LSgmnVUsmlP8quAFx7cVn87/AMC
         emPQVcEwsebqasU40T/iZAADFXGx1rT+aSGHV72JPQ+09RRWBX66WPjPS2Xb/G99htAJ
         VsrlkYrnUYefDrO0FaAh7tkOc2YucEWYsxK2RgRgyYSEHHblYSSrkR/yIDideGjYiEBf
         lApMqVuiiKd4hkX4QMpi+LgCS2joDJDeERv7/csBuOeiKepMRjtpUmIayGmIChIW0KIq
         eug8vMrB/31KSBpT3aMaUCQHoqRomwkOe1XSSgLy9c6pWqOl11a4XwNOZzIEHbscC3fN
         W3RQ==
X-Forwarded-Encrypted: i=1; AFNElJ/F8fVXT2z57StH18X3eVCykYh+Py1OoW97cVELkhFdf6DHkb8YQ3PlOVO4Plt/VJAF5r9kG6qAt1wul1sv@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQZmSaNjCiLKx3yjNRSF80vexhafkCA/2Dmt9ZKMbQKp9d/qK
	g/0UXvToj+CtVihXImZ6n+3egf34LzUaUyd+AZR73wCKlbnxxOupNGeGzwMp+BVwYdRCAwEUXi+
	MquCcITBPTnvKcCiPd/IbxnehKHqOMjI=
X-Gm-Gg: Acq92OG9l+DHHGnL7CTgccrt2UBcO3enGpLVIsowNuR/oeQtL3TNw+980OWaybpDqTa
	wuBUs2DQc5UKVFTmRbVEME/hnuJwWdc+AYQKXK1TQwlg2WCj4VI2X7EQ0Xr+zY1lWeSeoah6AXf
	tDagH8tzE37CZFL/yqiE2rTHwO/h//ErH0ZkF6tkjav62giZ8W1fuj+Mv2lRGI+Q10caZht9nK6
	ZcfSr8ySOMJlYY07IBXMWyaoWFs9156GmfWEYs6KZgteItSGVDA5oJ3Zxm9hAq65c71EsvtLveO
	TEv8KeVLDnw1nvfIcBGd/NVxD87jcH3its/dPQ==
X-Received: by 2002:a17:907:b598:b0:bee:1e36:876c with SMTP id
 a640c23a62f3a-c05a4c1703cmr211484766b.41.1781707896641; Wed, 17 Jun 2026
 07:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
 <ajG2bmhu6j9UWvh4@localhost> <ajJgWBCFYwz9OIo3@redhat.com>
 <ajJ1Xi1p9UhQvILi@gmail.com> <CAGudoHEyDz-Tbj=CZFK5XMLuLyE8B17NumdFVLf6MTTekFgRRA@mail.gmail.com>
 <ajKxJM5k9U5L05AF@redhat.com>
In-Reply-To: <ajKxJM5k9U5L05AF@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Jun 2026 16:51:24 +0200
X-Gm-Features: AVVi8CdjBR0lFOZsSJyfbL4WD4q2BfYSOlNp_8lVKa5u-3YhN9i4iyvCeMkkv1M
Message-ID: <CAGudoHG4r09syjknUo7rsZV1G01o0OGBvY3X3S8tQ0dfdSYSaQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
To: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Josh Triplett <josh@joshtriplett.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shakeel.butt@linux.dev, jlayton@kernel.org, axboe@kernel.dk, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 4:37=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 06/17, Mateusz Guzik wrote:
> >
> > There are trivial touch ups which can be done by adding a bunch of
> > predicts and inlining kill_fasync if someone can be bothered.
>
> I was thinking about another change, see below. It assumes that in the
> likely case another writer won't steal the pages from ->tmp_page[]
> before we take pipe->mutex.
>
> I'm not sure this makes sense, and I have no idea how it would impact
> performance in "real" workloads.
>
> Oleg.
> ---
>
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 429b0714ec57..9f07f469830a 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -131,7 +131,8 @@ struct anon_pipe_prealloc {
>   * pipe->mutex hold-time being shrunk. Any shortfall is covered by the
>   * in-lock alloc_page() fallback in anon_pipe_get_page().
>   */
> -static void anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *preal=
loc,
> +static void anon_pipe_get_page_prealloc(struct pipe_inode_info *pipe,
> +                                       struct anon_pipe_prealloc *preall=
oc,
>                                         size_t total_len)
>  {
>         unsigned int want, i;
> @@ -144,6 +145,11 @@ static void anon_pipe_get_page_prealloc(struct anon_=
pipe_prealloc *prealloc,
>         want =3D min_t(unsigned int, DIV_ROUND_UP(total_len, PAGE_SIZE),
>                      PIPE_PREALLOC_MAX);
>
> +       for (i =3D 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
> +               if (pipe->tmp_page[i] && !--want)
> +                       return;
> +       }
> +
>         for (i =3D 0; i < want; i++) {
>                 page =3D alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
>                 if (!page)
> @@ -548,7 +554,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>         if (unlikely(total_len =3D=3D 0))
>                 return 0;
>
> -       anon_pipe_get_page_prealloc(&prealloc, total_len);
> +       anon_pipe_get_page_prealloc(pipe, &prealloc, total_len);
>
>         mutex_lock(&pipe->mutex);
>
>

As proposed this will guarantee a big write which fits fine into pages
cached into tmp_page followed by a small write will have to resort to
an allocation under the mutex, partially defeating the original patch.
So you would need to add some provisions to check if you need to
allocate something even in that case.
