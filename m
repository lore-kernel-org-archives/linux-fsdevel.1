Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136914E1C77
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376938; cv=none; b=Ph+S/1jalFysbcy8BP6nxTMmUMvuOdkIgobH3Sfwe0YUtNtoJCJqt+udNxOwHCzyHUrz5OmFLIxQ1jg2zBvAgzIIvr4vaHoxzn2j9T2ajBMbDh8rtvXOD6fBFCQ4dYPbDNsBeGX6lULGU0eD3ReqJatqjwFBGVJRaumo+xboki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376938; c=relaxed/simple;
	bh=Zf0drRycsHKvrBGQ5A7l+1Uo/y3SsK1cBbIg6oWf7Ec=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SYf8v9lh43djUQ4+aWO/PkriSOt/XGBf3S7hM+w5kzxpHY1UESnf95xgnNMrHWhux/l5N6X9hgvDhiFi1Wb34y7DwVG9mggXlc7erySbQlAypEgFWSDgWJ5BHEIxW4t8ifn8MFFW1EObPZMvnAvV5rv9N0TVKOK03bua4/DlYuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=NqKB+Mhp; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="NqKB+Mhp"
X-KPN-MessageId: 367f232a-b934-11f1-a5a2-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 367f232a-b934-11f1-a5a2-005056994fde;
	Sat, 26 Sep 2026 00:55:32 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 367df0b1-b934-11f1-ac15-00505699693e;
	Sat, 26 Sep 2026 00:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=R7AWldrXJstZk7Hlf/GWqyF7ZVH0h2SguWY2t+clCo0=;
	b=NqKB+Mhpjw/g6i6YiE0aTBtEj5TLyP7yCiiWOxicfT79cfThIroiSp75EVvcQZuZ72PWOETAkzXub
	 /FzoZd2TEe9m75H8HhUX4VVjMQNpd9k5sBacq0Fh79BHpEb+LtGEN1LbE2IRjFpq90CC90Y1qWtuFr
	 5ei2LqQZ8sb8iTG2uhbfD+xkleQmQF1N9zbpFNb5/jKmQyyvT7m4eYosUAeFa8obJB/kUa572/pVaX
	 S4SPfEdLKJ3zi2J1u7Gb7/cN6wLrPk2D0BcQPgLziKZDSpzFsRonoOfQ5fdNK7iw5o9s1DQhM3wGvf
	 7v5fezaz9/sLFSzXfxt5NUrMPFMMoUA==
X-KPN-MID: 33|/xSvkwkNN+rIq0nX+3zcmTmpP/sJ5+HNiqqxw8jrByLLtCc5VlJTanQjMKgwvDr
 LB+UrwahYc0rn9s6jiblBJY4HHsvgbml7gwU89VbK97U=
X-CMASSUN: 33|d7zrBv5YghRAOhOHwEf4Oa6aO8wXJXZeWy7ZKeQzg9X6LjW/GsdxTeQoBFI/RE+
 xUkbwCzj6H7q5lnlxfbnPbA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 3678337c-b934-11f1-8edd-00505699eff2;
	Sat, 26 Sep 2026 00:55:32 +0200 (CEST)
Date: Sat, 26 Sep 2026 00:55:32 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <338872948.213197.1790376932845@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260918-kargheit-reibung-meinung-b0030a0b063e@brauner>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
 <20260913185016.523376-9-jkoolstra@xs4all.nl>
 <20260918-kargheit-reibung-meinung-b0030a0b063e@brauner>
Subject: Re: [PATCH v6 08/12] vfs: change ->create/->mkdir operations
 unavailable errno
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


> Op 18-09-2026 04:04 EDT schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> On Sun, Sep 13, 2026 at 08:50:12PM +0200, Jori Koolstra wrote:
> > Currently filesystems return -EACCES for missing ->create and -EPERM for
> > missing ->mkdir in vfs_create/vfs_mkdir. Instead of duplicating these
> > dubious and inconsistent error codes to lookup_open(), change all to
> > -EOPNOTSUPP.
> > 
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> 
> I suspect that still has regression potential but we can try.

I know, but the one that showed up in next wasn't related to this. We can
drop it if there's issues, but it would be really really ugly. That's why
I suggest we try this lighter errno correction.
