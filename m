Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB493B27C5
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871830; cv=none; b=iiWPNdHoLF720sjUdVMZUAX+5D+wwCzav1tUi9Ye6ZfBOTQ8QMrrNJ43iq5asMNbKv55hCbhcxQ2R4STjnq7iA/3SAXTXpRao7pxeWNjGAuc9T7MAyDzrYFqhyT9M6BJX6vXLBZtWgGGAHI7qDQeoifbjPzqWZi0n/4hU3GJuKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871830; c=relaxed/simple;
	bh=s8ttqXQDG6r6mW/LaqUe7IToRduqXZ8BBaeNb2vjI9g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=HpXsvL3yQv4cOGRzDn/0Ycs5onLUwKHmnGUuSrNtJDKW6b21Z0UjagQ9A2lSZQihghwzTpGkmVbvx11aOm6JbVsASHIKTjQdu/9l5+szB27NrBEZIys4xFagX9qu7ThgJEtaSSvRy3rcjWOW3mEmtCgfrdXbeKUsyv7Lm1KxoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ZX4BmddH; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ZX4BmddH"
X-KPN-MessageId: 7871a97a-bdb4-11f1-9e92-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 7871a97a-bdb4-11f1-9e92-005056999439;
	Thu, 01 Oct 2026 18:23:43 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 7870b63a-bdb4-11f1-9235-00505699891e;
	Thu, 01 Oct 2026 18:23:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=N5/k9BCrYi9T273mjHI7/n7LHEfZll3Txje6QyNRmvM=;
	b=ZX4BmddHXdVA1H//49ujj09lXw9pyXtDzxk5ZtplpYEfX8kM/vKkKTCUQHHeYJXkiQ05mcD4lBU4u
	 +h0goaqpJtCLUUf0lQOwR0xKXdLV1HRFdYfI/QFxQDqUBEQCntoCz1lm1KkNw1TVmI1lCsENNtJAow
	 6C7kOY9906plaFPlkIZwc+k+E9gMYcJya5VuL7XR0msfTsHqcTc9T1nQclPBtsraBu1FcUApLiqB/g
	 jQ99eFxRAy5AInip7NrVWB9X4xKdrgJRVSThx8BkqG7pruYg+4j1TqCqyANA/mfyYW9HyBi/FTc85s
	 EtTfRLCQhokYzyBppLE56T3jpXQbcgg==
X-KPN-MID: 33|KICE6c+2Dyy4oUxAdwyRueM+CD+VyLOt6Fj/q6T1Akd5MOQGROxtQLVlNuL/Fqk
 IDZGF3Sqglcj9C/szXOOqQg==
X-CMASSUN: 33|pidFDbjjk8JsxjnYBivuDGLavzgPghmcYDY/A56Kf6HsxxiX0AQ4hv89fBqDMP0
 2E8YvZ40OseKyPFPLa0AxVQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 7866d2b3-bdb4-11f1-8edd-00505699eff2;
	Thu, 01 Oct 2026 18:23:43 +0200 (CEST)
Date: Thu, 1 Oct 2026 18:23:43 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Message-ID: <563229463.934215.1790871823693@kpc.webmail.kpnmail.nl>
In-Reply-To: <CAOQ4uxism8-zwCDgGjO4Rxz6DqOkZJeZOeYKHf3QaBDFZHpcFg@mail.gmail.com>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
 <20260913185016.523376-8-jkoolstra@xs4all.nl>
 <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
 <178972607557.207413.4312278359822083538@noble.neil.brown.name>
 <178977609418.207413.15011378414000392029@noble.neil.brown.name>
 <1010887891.582666.1790682845752@kpc.webmail.kpnmail.nl>
 <179072013439.37859.465558431050704411@noble.neil.brown.name>
 <CAOQ4uxis4tsea6fx+9iAffVX+qwBC9KzHg5GcP7ahthKd1T9KQ@mail.gmail.com>
 <1910540525.790746.1790806610320@kpc.webmail.kpnmail.nl>
 <CAOQ4uxhYHf-gAkjdhs37vZREOcNds5a_6c3nBX0Lva3resofmw@mail.gmail.com>
 <1000409963.929534.1790869356300@kpc.webmail.kpnmail.nl>
 <CAOQ4uxism8-zwCDgGjO4Rxz6DqOkZJeZOeYKHf3QaBDFZHpcFg@mail.gmail.com>
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 01-10-2026 17:59 CEST schreef Amir Goldstein <amir73il@gmail.com>:
> 
>  
> > > Maybe I am missing something, but I think you misunderstand me.
> > > What I mean is - if directory inode has a ->atomic_open() op,
> > > bail early with -EINVAL/-EOPNOTSUPP, because this is a network
> > > filesystem that does not support atomic O_CREATE|O_DIRECTORY
> > > and in most likelihood never will support it.
> > >
> > > This gating criteria is not dependent on cache state,
> > > which is what we wanted.
> > >
> >
> > No in that case I think I've understood you (or maybe still not?) My
> > point is that we can't do that if we want to be able to individually
> > support O_CREAT|O_DIRECTORY for some ->atomic_open fs. If we bail early
> > the how can say only NFS support it at some point? You get into the
> > situation where everybody needs to have support or no one.
> >
> > Does that make sense, or do I still misunderstand you point?
> >
> 
> If we gate on an existing criteria now like ->atomic_open()
> and/or ->d_revalidate(), we keep semantics simple and it
> does not limit us to change the criteria in the future.
> 
> But I don't insist on this criteria - it's just a suggestion.
> 

Oh no, I don't think it's a bad idea. I was just trying to understand.
And like I mentioned, I don't understand the detail of ->d_revalidate()
usage.

What do you think about Neil's suggestion to keep ->atomic_open out
of directory creation for the time being with:

1. use ->atomic_open(O_DIRECTORY) for lookup, no O_CREAT bit passed in.
2. if positive then done, otherwise (on -ENOENT from atomic_open()) we
   call ->mkdir
3. open that dentry in the regular way, WARN_ON negative dentry return

But I don't know if the kind of atomicity I care about is affected by
->d_revalidate() filesystems. With O_CREAT|O_DIRECTORY we just want provide
the mechanism to ensure that the process actually did the create you get
the fd for.

Best,
Jori.
