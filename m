Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC04367F3A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775011659; cv=none; b=Y4T4VfR8Dwr/8OGWVv7Gu3ijUu0Y6fVXSDFTZdh5rMct3i+1rZ2e2Qobg/VKgtdszLpXqlPXHr69Mf398rtGfv/lPvHxMLVQjUSkb5nXKsNO6lXlBjGAxG5WIpOeJrV+v1HIKZrW05CnIDTBwHln2965S42HM4wfFOxJM13JfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775011659; c=relaxed/simple;
	bh=1OXrAsEzezPFRuS8DDbw046wDdpltvA01sIXBeQV/ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8gxSOrxdJxySMaaFYo6X2LTvRudHZRyu5G83CLYQtXAjkqsgsdoMGSo83yvH+rksepYM8yo6SSc+QQcsmEtbVW2MAbzM6EmMszNOjfpj8LlOraDRWUU0Eq8NQJJY5mAdY059NzWShlGmGGrLcXr7SehLKHHxMPcAEyAsph2mrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIn89lnR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIn89lnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0968C2BCB2
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 02:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775011657;
	bh=1OXrAsEzezPFRuS8DDbw046wDdpltvA01sIXBeQV/ck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EIn89lnRkDctcfay0YFZQcGtbhcxA7+hOlzZY+Vps2YGIZG31Cw2B0qVCwVCJ2Gk8
	 jeLCCo0B8bRLfvev5ZgQUWCsjeXhm9qQ6/igIPeNDa0fAvTHkmaFeQ0Ja+8mjvB8d/
	 mHT81x0JRZU1/gYcZ11FmU3e2awyni120pFE9qtk8o9NNso8g0jGY/Rzoy9Tl6DnGM
	 WKz031USCtjtz6N7kVaQib9eREDbHqFaTmC2gLbol/bpwk9YCs7cu4zulCz7gWk+Ms
	 xrjVMSgyjymGH6G11cvvUeXJHs6Ht/vJUBBpDsCvNq5E3D7LvE/AUvcE8OSwLUDSFZ
	 C/RBw+HiMqUZw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66c17372965so4038152a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 19:47:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWaqTZfvU6ORiBOZ83DGC2Pr+QSFGFprSzhER67dMqa858A44MAzpYBEKc1fGvDMLyN+9SUMzdWrgwHYVcb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+SWXVbLGkLHXperzjle6CHYgvHC1F+Tnk1VDQKpMX0XxxQbFb
	w9trQ+eyyZFl7Cx9p0oN3uVCAmux7WX2bUzt9fFK+Ou2Dq8F7I84JF4yNUOvQNH9U8H+keFo54l
	Nvg8K9thTYqNjImxHdzJcCwPO6gu1fJQ=
X-Received: by 2002:a05:6402:13c9:b0:66a:72e5:6af5 with SMTP id
 4fb4d7f45d1cf-66db09e2695mr1165796a12.17.1775011656352; Tue, 31 Mar 2026
 19:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-2-linkinjeon@kernel.org>
 <PUZPR04MB6316DABA9CEE62B3873600598150A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB6316DABA9CEE62B3873600598150A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 1 Apr 2026 11:47:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_ZtJeB4Xhcv0AhDrkOYCwtcLjrNnYLYnFYoPci+eYrUA@mail.gmail.com>
X-Gm-Features: AQROBzCEmBBjF9_4Ra8XbB83_YqV6BtjRnqmzWmcUBWoY17OuMRKMAxeu4ecwzs
Message-ID: <CAKYAXd_ZtJeB4Xhcv0AhDrkOYCwtcLjrNnYLYnFYoPci+eYrUA@mail.gmail.com>
Subject: Re: [PATCH 1/5] exfat: add iomap support
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"anmuxixixi@gmail.com" <anmuxixixi@gmail.com>, "dxdt@dev.snart.me" <dxdt@dev.snart.me>, 
	"chizhiling@kylinos.cn" <chizhiling@kylinos.cn>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 11:24=E2=80=AFAM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> > +static int __exfat_write_iomap_begin(struct inode *inode, loff_t offse=
t,
> > +               loff_t length, struct iomap *iomap)
> > +{
> > +       struct super_block *sb =3D inode->i_sb;
> > +       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> > +       unsigned int cluster, num_clusters;
> > +       loff_t cluster_offset, cluster_length;
> > +       int err;
> > +       bool balloc =3D false;
> > +
> > +       num_clusters =3D max(EXFAT_B_TO_CLU_ROUND_UP(offset + length, s=
bi) -
> > +               EXFAT_B_TO_CLU_ROUND_UP(offset, sbi), 1);
> > +       mutex_lock(&sbi->s_lock);
> > +       err =3D exfat_map_cluster(inode, EXFAT_B_TO_CLU(offset, sbi),
> > +                       &cluster, &num_clusters, true, &balloc);
>
> num_clusters is the number of clusters which the region [offset, offset+l=
ength] is
> distributed.
>
> num_clusters should be set as follows in both __exfat_write_iomap_begin a=
nd
> exfat_read_iomap_begin.
>
>   num_clusters =3D EXFAT_B_TO_CLU_ROUND_UP(offset + length, sbi) - EXFAT_=
B_TO_CLU(offset, sbi);
>
> And num_to_be_allocated in exfat_map_cluster() should be set as follows.
>
>      num_to_be_allocated =3D 0;
>      if (clu_offset + *count > num_clusters)
>              num_to_be_allocated =3D clu_offset + *count - num_clusters;
Okay, I will update it on the next version.
Thanks for the review:)
