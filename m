Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D42DECBF
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784898287; cv=none; b=EmAVRHliNcmX0KSD6JV66OtRcV0/42yG+bXBXvHGetjGoOapB5VSv5tC6GrWINRjFVdeYrdkNbcuZ6cYNFEPBTQ/+CFCbN9eG1rFKZIDCOecDula+BRobrJeXupUBtnVwnmrbZun9A8php3bj7zfvar0EaivpfgKFwxN5e8KvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784898287; c=relaxed/simple;
	bh=HA5snKxeJJY93i5Oxlv7p9UMmZEw0vrhCoAvqAjR8AY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Wq3YOXO5RzmDccW+5nIt42itdN3RIkc3ox6CibBFL7cxtvI+0AN/KdEiCsB410gWvcqVgnnc8bn0YN5XZqc7wt7xhpOVf8mV6zQrKG0ZOnFOwfnu0DBHy5s+pTW8A59dzgPQSYmaruTHv7OEcFdVUE7+ueVFdejIIQ1oN4GuaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=LarElMJX; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="LarElMJX"
X-KPN-MessageId: 381caf62-8760-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 381caf62-8760-11f1-bfba-00505699b430;
	Fri, 24 Jul 2026 15:04:35 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 381b6d39-8760-11f1-91cc-00505699891e;
	Fri, 24 Jul 2026 15:04:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=H5gm44P9cCgFu1aKLgelxBQF+ntzM5LHVN3CGD3Wmfw=;
	b=LarElMJXveL/62z9wVz6ETaN6iTHDAu1FUCPuaqQF0GU/cKvbRqLX02g+Hj+RoA33uiA4ytzF5nWO
	 Q4FEZhZyZwnzfr78GnHencITwTGGa0R2UKoo9mR266G5tdRnh3snuXuc5XUILtF9HV2Eu795EDHiDt
	 GelkuwtaRkptoq9gXwPRtujHAlfeK8vGpBAWsnjEXGgHm5Fjdr0mNOuujhqoWBp5t4tBOiH3E2K+qb
	 LIz1sjpoMz1vLgIzy4PLS6QldR3p0rA6GITKl3Q/DpyTljARGaolSAPHE2i9EzjckYbZjnTdCnJvmg
	 +1YiEZsR0pUhEqgrYp/5WmetmvUSxjg==
X-KPN-MID: 33|Vmp9hYcA335gl6BVVhiGlcOroQ+aBU3IrYWmGfkPX8Ce6bk3rEytqZ0a4VoXupz
 Mk0ug+HuCOuddP+ehbSY+FuL/gDW5wm4Mhc3RzaIZLtQ=
X-CMASSUN: 33|p8Bxljk3byLzlJs1I8hQrkh5HIAdupQp/wJiWmM7sWLb8Ekhy2l0sn2bIanj+aE
 bxOoZTNW5CKgG6tDU9Mecmw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 3814a530-8760-11f1-916a-005056995d6c;
	Fri, 24 Jul 2026 15:04:35 +0200 (CEST)
Date: Fri, 24 Jul 2026 15:04:35 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Christoph Hellwig <hch@infradead.org>,
	Pedro Falcato <pfalcato@suse.de>, Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <2053425117.32681.1784898275264@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260724-jazzband-benannt-bauzeit-08186a6e1986@brauner>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <20260707-vorteil-unhaltbar-apotheke-47bb105161ff@brauner>
 <alS10NN_OduZEqvt@infradead.org>
 <20260722-mundpropaganda-vorwahl-funkverkehr-48efdde92a00@brauner>
 <amDBQN5lCGbRxGWm@infradead.org>
 <987276143.170754.1784726828216@kpc.webmail.kpnmail.nl>
 <178475745953.3371781.2895727677996716858@noble.neil.brown.name>
 <1713122837.215334.1784765444011@kpc.webmail.kpnmail.nl>
 <20260724-jazzband-benannt-bauzeit-08186a6e1986@brauner>
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


> Op 24-07-2026 11:33 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> > Anyway, it is up to Christian.
> 
> Please send a new version with support in openat() and openat2().

It will currently also work for open.

> Fwiw, we have have not just a few examples of combinations that either
> were ignored then became meaningful (that's something we shouldn't do)
> but also were meaningful, then were rejected (something that's fine) and
> then reused.

It's already there[1], I see now that I forgot the make it -v4. Should I still
do that regardless?

> 
> Thanks for the patience.


[1]: https://lore.kernel.org/linux-fsdevel/20260712175539.1565444-1-jkoolstra@xs4all.nl/
