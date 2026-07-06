Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D947424674
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340141; cv=pass; b=NO83QTTWg9bcUJKmUun41QZpwdk1fT2gTDy0PhESFtpHY7wIkNJHvD/VhyCD+/Yh30+PuWEbApw/E6mAS0xnQSzJiUZ6wjRIdPFMbacmeXpeQa8WybCpyac++IvWFPJCV4ZQBhn7QNASn72SxUFpRoHxAzd6wDYkaX/LxeMDQGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340141; c=relaxed/simple;
	bh=CbGUa94GJcINTxoi/M3EtQma5R4FLilaK9jbb4N5S94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cz0Szhw1qxHaFJpPNbkYECrlNkpTLI4wEujNQMsedVXZs8lpK3tkpjv1W0srC5mKHNefItDXVciG4cqKWadTDgM0KDHmYRKnkvroX+P7dgBYToSPdkVtlUvkYRf4ssYHJ1CcrPQrZ0bjTtNJoV9c41NvgO+tdyOwmZMZzCf564k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dJ8eBuEe; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dJ8eBuEe"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e51d3d83cso143174785a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 05:15:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783340138; cv=none;
        d=google.com; s=arc-20260327;
        b=igqgTu+GNTyc2jtOfG3AaOqvKO1jS6V1/Nz46+XSl7xF8+MX4iqqBy7zCVceqAicrW
         e+PGvtPvSnlsJW5vQlZgGdtK7IHgF9GU6zNTadMJjgRB8j1WsTTLiQx9CRx/7kOM08cS
         KdImW+mUf3PoTfdQneekZd73vDA4T6Ti3WFb4v6ANbt7zji69QESK0Q2NkUQgMEc0rXX
         g1S/iV+/DqhgaDVd9W9F7lae8PRAN/Rdm4lZ8dK5tgUrTgw4WIAKsWvcr4AAitDAEp3l
         qkNN9YIHMROE23xFztXFK+X62YkCXBYx5d7WvBl+AmbgZ613I///gl7MH9idQoP9FgEp
         yFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+yRAvxXQ+YKzcyw8T/PhW1FGamEYrVSW8Lfd6EOBYZY=;
        fh=wBzZiXEhuZe6Y1OkXW3tsdzAFN0PIZvmoxbeFOHouoQ=;
        b=I2eD88GWeaP9WWvP8i76AoCqNv/ZjbNpNXOQfoxdismdJ8/jawsL0nNe/WNAITODzG
         ZUTep2i1g5aftbC6oxyOlD1XVC88iRUGtCKU5+lSHOSEefzJB/iTGwL43DPsxUEDf7dx
         ClmSXpTdMtUqrd+7l0yV7RnFL8Nx8RYYbogmzSHZRep0CiLC16W0amLsXpEljMhUjsvQ
         eD1K9qZXbSH7suDN24OYInsPcLoO+P4xJg/p70rl2EfkiNbTh/w1xtNQ07++ci16xnAw
         WgCB0wxmxpTE2ftsszlBEV08n1XY2QQD9c0HN13KZIMbTGM9YfOfOlPRRafmT3g+ECt0
         e0FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783340138; x=1783944938; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+yRAvxXQ+YKzcyw8T/PhW1FGamEYrVSW8Lfd6EOBYZY=;
        b=dJ8eBuEehC2vKGHuEvh+qTBTJPgoqXQkH9yodAtwVkFH+oYPU+69wXbU96M93MaFaB
         I4RSzPoHvsKsD14ZSzQ3jpt0qAHaO13MmKzowyXclw7ZY8zF+pcLML0zIkB4AaRgTUPS
         KpigmcgXKGbAUlcHFhLUnsa/NwZVgMfIY47TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783340138; x=1783944938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yRAvxXQ+YKzcyw8T/PhW1FGamEYrVSW8Lfd6EOBYZY=;
        b=HRt48Vh/62GVA04cyTjzFZbJojOdIPTNn+bC/dNi7Y1T9wnea0eA2O+L5k4VE061BX
         gVxZzM+g8/VYsn8T7SbmkJUv+E+++fcsN0yGcxcZnKLxBk1T64XJbaPeWXbxINyx3kBk
         XQAc9POA0PvgsUtfhnEGTsW7kYmp1j77mIOeRTu2uc+rG88DMCHbkjPYVJIqfqziPbsj
         vDKZu37mGErmXnPLTc/0JY3fCA8Tb6w1OAoXpuHr47d7bm7ziFdlxfLbcWqKEG1BAh8O
         V5hhXKPxcVY1bnbCt5CEQEalignmOWc/vRrAJglxGyCt9+svT9A9/46a0avOGtm/Cbk6
         zFpA==
X-Forwarded-Encrypted: i=1; AHgh+RpDgZQGFnSotdBjji8NrEiwCN8lQ9fhKNmOne1qBklijO2mkXK0cmXA680/HGC8LmPctxP+hNc5ohpFfMHk@vger.kernel.org
X-Gm-Message-State: AOJu0YxDoUBMCMgDP5+5RnXyd5X6fB8YMI3f34BmltB6a88X0wkwuYmv
	ielIUq69WwVu8oFXhQb0KyBZefHswf2e8DsWAjnlT2a9JBJ7gZH7B81euR2sM/gdAqcpatvsr1x
	Q9La39gfUGHrLMXHsgkGasPTA65yRJoeeGmNTOX2Myg==
X-Gm-Gg: AfdE7cmA6ntl1i2MsEiiBJlDPodoj5iW5bUqAyBTByEdbhk4oPOy2VCAiZlv8E5H7EM
	UWFSxgNoZOijTFmuuHPppVmrrC7mMVLBfJ5rQNQd0V4NM9Cb973dkH8Xl5J81zeZWuHqidB0hAO
	C1qraRV46/55hGghA13Fw9XyoWOOtent7gzdZLJOADIEfoAh+AWglIF1hXneciOOuNgAlf1cvGH
	Q9gHY1upTeMep9znpRf6WnGOV0P9Iosfjolpq+058nCPseZ2vTOXxXLv3xjm3T6zhaUY+3SF7da
	ZZyTDjR4GNEmQoqgOpE7lDEJH4c=
X-Received: by 2002:a05:620a:178d:b0:915:f27f:e70e with SMTP id
 af79cd13be357-92ebb55a8efmr34373985a.23.1783340136820; Mon, 06 Jul 2026
 05:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702021105.3406439-1-neilb@ownmail.net> <CAJfpegtCL8S=zjv-pwxrX-9YXL0HLGb8Dsw_XWFF_H4Ui3MTZA@mail.gmail.com>
 <178333912248.27465.12516797587230528370@noble.neil.brown.name>
In-Reply-To: <178333912248.27465.12516797587230528370@noble.neil.brown.name>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 6 Jul 2026 14:15:25 +0200
X-Gm-Features: AVVi8CeuDOFDSz8Gvt6e4KwYQoEpDBYAPNRfZl-KsSvQOMnVuq8THZrkeSzzcow
Message-ID: <CAJfpegtMmSLCjn+ZyhyP2uHzJyqUxDYFjXg4N9M_o=UP5Dk+-A@mail.gmail.com>
Subject: Re: d_time and d_fsdata
To: NeilBrown <neil@brown.name>
Cc: Steve French <sfrench@samba.org>, Steve French <smfrench@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jul 2026 at 13:58, NeilBrown <neilb@ownmail.net> wrote:
>
> On Mon, 06 Jul 2026, Miklos Szeredi wrote:

> > Wanted to get rid of d_time, as it is no longer used by VFS, only a
> > handful of filesystems.   Still a worthwhile goal, IMO.
>
> I thought it might have been that.  Do you recall why you didn't
> complete the job?

Probably got sidetracked and forgotten.

> There aren't many filesystems that use both ->d_time and ->d_fsdata.
> Just nfs and fuse I think, plus cifs and afs which I'm trying to change
> and could manage with a DCACHE_PRIVATE bit rather than ->d_fsdata.
>
> fuse could move the d_time field into fuse_dentry at the cost of an
> extra dereference.  That would mostly affect fuse_dentry_revalidate as
> other places that access d_time also access d_fsdata so it would just be
> another cache access.

This use was recently added and I didn't pay enough attention to this
when reviewing.  I'll tackle this.

> nfs is more complex.  It uses d_fsdata for 3 different things.
>   - the "block opens" flag that I added and could be in d_flags
>   - a path name - only for the IS_ROOT() dentry
>   - nfs_unlinkdata - only for DCACHE_NFSFS_RENAMED which need to
>     be unlinked on last close.  This is only ever present on
>     regular files, so we could repurpose d_children, but that is
>     a bit icky...  Maybe we don't need a d_time for DCACHE_NFSFS_RENAMED
>     dentries - they are quite special.
> Also nfs uses the lsb of d_time to indicate something about delegation,
> so it only uses 63 bits of d_time (31 on 32bit hosts).
>
> d_flags currently has 4 unused bits.  I want one more for locking
> changes.  Allocating 1 for fs-private use (e.g blocking opens) might be
> acceptable. 2 might be a hard sell.
>
> We could probably make it work, but I don't want to distract my self
> with it just now.

Fine.  But not adding new users when not absolutely necessary would be
a good thing, IMO.

Thanks,
Miklos
