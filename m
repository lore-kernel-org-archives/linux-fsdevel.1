Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E4533A702
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607688; cv=none; b=Urrqy8B85dPtA2+C2ZX4XvDkydvfecu0atn+zCEaCQC5dJZ5g6JhmYIsLUEJwvPJSp6shzcFA8CpCNMcqhNm2wtC5ze9Vk7NyW4ls0Yo1oGT3oX0hs42w8y0KYTQAiaCpTE+RbxAvC1vhAQoik0hppxuPGGv+0Zj0baHk4/J0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607688; c=relaxed/simple;
	bh=0p/7ww8JBy7cbSlbKm2upA/IE3s1NoNmFIQh49k5aVo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=g7ecfwIvGtOs8wf/xMPp/yes5qmeLa3n0LSsYklseye1D5ImCKtuTo9LlRQ+T+5xRoxkKiZpurHmEH8A+mHqD0Mp2jbJijhUzJEzP0lzFa8Yb5ExotHXGiPp2a++oGS6goKNpTV/fNd+75kh+R6Jt0LgV1BfW5M3umhliFdGWik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=T5aDoE5J; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="T5aDoE5J"
X-KPN-MessageId: 4fd05d54-7ba3-11f1-8f54-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4fd05d54-7ba3-11f1-8f54-005056992ed3;
	Thu, 09 Jul 2026 16:34:37 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 4fcf3695-7ba3-11f1-ae72-0050569981f5;
	Thu, 09 Jul 2026 16:34:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=HmJxCdiosIJ3y1MPHG8bWTSHcdqZkbcDMk52XYEuI1k=;
	b=T5aDoE5JzS7XP2YIbicr5RVR+84W90G5lpVPKtDqLOyuYv+ZJpxtivhBn3DKt0oVKwaORLi0KfUMI
	 tvK3EgTWWf9FyvkX3jvxIu8MKWNAultz0IsFhfgR7735UPwsyKF+DzdBdqtF/u3I0o+XyYwJRYqxVQ
	 onzlMzE7wnJuBMAFGGL8CqmdyV6QotkglGjWhORh2+pfhu/0lbPyzxb/IbyvplITGFNcmFmrrD2ZkA
	 crd4dWRfCSncPeTdaq+j22IKvEhtA+o2xei+wcjSI7ntuvhre/m59NQL9r3uFAGbRrXB4DYQ28z9DF
	 gBdxqkRFpUPn0qdwOjQKS/FXYSj+cxw==
X-KPN-MID: 33|MOIVPITTR6aAJM4RK8cGZYdPwGh8zZ5oz7LvLztV25V18QPYpphx4CYzDw6qMdR
 T+uv9C6E87FEaSyC38TBBAjWSf+b+XeVutrZfwv1OzKE=
X-CMASSUN: 33|c5FOAAFCmcfJX4CCkUgQJr6x0KQeC+xUHY8mer6AJXnADDWukLHRTC8gQSGh+hs
 QEe8C+TdXig5B10yKGl3Adg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 4fc46956-7ba3-11f1-8edb-00505699eff2;
	Thu, 09 Jul 2026 16:34:37 +0200 (CEST)
Date: Thu, 9 Jul 2026 16:34:37 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Pedro Falcato <pfalcato@suse.de>,
	Aleksa Sarai <aleksa@amutable.com>, Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <331565565.497684.1783607677333@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260709-skigebiet-fakten-galopp-29f4f1170f61@brauner>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <1464441345.181098.1783418805206@kpc.webmail.kpnmail.nl>
 <akz_Ik8_eTnXav1H@pedro-suse>
 <1400609680.217714.1783433931054@kpc.webmail.kpnmail.nl>
 <ak5rHOsvtMX1j7S3@pedro-suse> <ak8-lSfOy0oL78N9@infradead.org>
 <111142800.451666.1783594280454@kpc.webmail.kpnmail.nl>
 <20260709-skigebiet-fakten-galopp-29f4f1170f61@brauner>
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
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


> Op 09-07-2026 16:21 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> > Maybe just backport -EINVAL to every kernel since introducing openat2(2) then
> > that can be used as a test.
> > 
> > But that is an issue if openat2 is blocked. I don't know enough about blocking
> > syscalls to know if that is a big issue or not or whether it can be worked around.
> > But something like this seems reasonable.
> 
> Please just send a new version with the relevant issues addressed.
> The last comment clearly didn't even bother to figure out that nearly
> all LTSes return -EINVAL for the combination. 5.10 and 5.15 fail as well
> but are broken because apparently they didn't get the actual backport
> years ago. They die in December. And upstream doesn't care about
> Back-To-The-Future Frankenstein kernels.

Yes I will this weekend. I'll address your and Neil's feedback (thanks for that!)
and also split it up, so that the faulty audit handling does not block the rest.
But I have to be careful as lookup_open() code is a bit finicky and easy to
miss stupid stuff (Sashiko caught me a couple times). 

I also still need to prepare my OSS talk and I have a full-time non-Linux job
(hopefully not forever), plus trying to do some reviews. So I just didn't get
around to it yet :(

Best,
Jori.
