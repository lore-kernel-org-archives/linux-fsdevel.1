Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B6F3EFD3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376897; cv=none; b=hXjp1hUieoUvIIqN5rmbWPOlrY0cdqDYsGuqOOucE2mjkMPOHyWPhaS/wqdRscOLWxL0iIeWpAGDxKcrAArry1KmiM08XiX89ePEsP59R074Ry2BXWeeqsXN8B3bXuFH9Gzd9UeSJuX0GDAbqExWjl1LsLFBCezNZdEe8pwWZ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376897; c=relaxed/simple;
	bh=BokudRr0Ig2vybrurzBz2Uey3DtFcBZb0Muh/aq6110=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XNRBlvABBpjXnZjjT6FWzsoHmh8SeQn6wwIYiP80tNn5wzTvWUqNynaxMw+Su/7D4MwNYXLUb3EqT1UrkmfdBD8LiSF1drQMJ7Ejep8OuTvSU7y1baIi4Xn5aMV3eNax/eOCHDa7fSvExCvnnYOcIXz/K9ytX8iJkRQMZW27KOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=G0kX57qq; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="G0kX57qq"
X-KPN-MessageId: f4a8bd7c-b933-11f1-a5a2-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f4a8bd7c-b933-11f1-a5a2-005056994fde;
	Sat, 26 Sep 2026 00:53:42 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id f4a76553-b933-11f1-ac15-00505699693e;
	Sat, 26 Sep 2026 00:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=k1lC/A+bhNkwWdWBeNl7rE58csj8gxHyjC42tMUKElw=;
	b=G0kX57qqVeiPpKhJrEkCSgWg1YQTG1puPVI2N7RCKRKN0e5S/kGNurX3fwO94hZm49tOJ+KeXQA9c
	 fWjdVhLMj2rdQYoJR82jqtgJt8C+BdT3j/dOCwBjG9wlYSubqZ9cvhY++YNLMFWemflApgZFfoEZD9
	 z/sL8rTHrbkBLqAHxGAPKxvyRdBh/FamJqxExWc87c7s02NGcDtu4/pJlSilgVMhtS0yioaYj1Gygv
	 MF6CCotyI5h5Rs4n2tkAKIRo6VknANUNPqaEzYfRnGL6GNf0f9foiQr1pFc4RU0pQxuByylIqEtbfW
	 d2NwE0HZcQDmRs897uC66N4QhdCw1WQ==
X-KPN-MID: 33|D9BG9CV7W4xBHuoUFJm0Mjxv2ot1PlG11XFGVBxq4GrOsx+3Bu5vw6nGpAvlNJZ
 scaAlGHl6oJ0JkZeYf2DC06cTw3bqGQ3YFNmfhVOjqbA=
X-CMASSUN: 33|lQ+YEFfoifV4z2hsACFOl1sFcKCawS6x27Kp5oHdGThPcxux/UbXZDfVYiPZqFx
 eNhTyixRp6kkwkYLsHevVUg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id f4a2318f-b933-11f1-8edd-00505699eff2;
	Sat, 26 Sep 2026 00:53:42 +0200 (CEST)
Date: Sat, 26 Sep 2026 00:53:42 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1613780279.213174.1790376822390@kpc.webmail.kpnmail.nl>
In-Reply-To: <179037158183.37859.9652046156677268952@noble.neil.brown.name>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
 <20260913185016.523376-8-jkoolstra@xs4all.nl>
 <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
 <178972607557.207413.4312278359822083538@noble.neil.brown.name>
 <178977609418.207413.15011378414000392029@noble.neil.brown.name>
 <20260925-zonen-dachwohnung-akkusativ-6a1d1a595810@brauner>
 <179037158183.37859.9652046156677268952@noble.neil.brown.name>
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


> Op 25-09-2026 17:26 EDT schreef NeilBrown <neilb@ownmail.net>:
> 
> The current proposal leaves all ->atomic_open using filesystems as not
> supporting O_CREAT|O_DIRECTORY and I think that is reasonable.  Getting
> them all done in the one release is probably unrealistic.
> But that is a slightly different issue to kernfs/tracefs.
> 

Exactly, we're not going to get 100% support in a single release anyway.

> I wonder *why* those two filesystems don't do the lookup to instantiate
> the dentry after mkdir.  If it was just "unnecessary" then we can safely
> change it.  If it was "there is a common use-case where mkdir isn't
> followed by a lookup, and we can avoid cluttering the icache/dcache",
> then we probably don't want to.
> 

Yes, I'd rather fix this there if possible, but we first need to know the idea
behind the curious choice not to instantiate the dentry. Otherwise, we can go
the ->atomic_open route as you suggested.

> 
> At this stage I think I would lean towards O_CREAT|O_DIRECTORY not
> working on these two filesystems.  Neither support a .create
> inode_operation, so providing a .atomic_open would be quite easy: just

Wait, so an O_CREAT opens already return an error on kernf/tracefs? They
only support directories? I have to read up on these a bit over the weekend.

> do a ->lookup and pass the result to finish_no_open, but return an
> appropriate error if O_CREAT was requested but no inode was found.  That
> would then treat these like other atomic_open filesystems in that
> O_CREAT|O_DIRECTORY wouldn't work until the fs maintainer accepted a
> patch for it.
> 

This sounds good to me.

Best,
Jori.

PS. @Neil, will you be at Plumbers by chance?
