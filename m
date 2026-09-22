Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3FB550DC6
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089173; cv=none; b=EToyOqTNad0sF79K56a83wlCGIuJKbVSAvc3dwuQ0p3SxfR/Ulws6uMQzgZUNisf8SgggnMS6onZXnK9DGSxhL8k6OKM9BuxibjjiWHVZ8AWHURTBRWzzQnQWmmkEeit90ZFfcuw8GK5KTD6vzjrlo4W17L82/picvXEzaDep1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089173; c=relaxed/simple;
	bh=0HlNT49tycEDsqvOgozUqD1L3BGYbLzAuEjThmxrNbI=;
	h=Date:From:To:Subject:Content-Type:Cc:References:In-Reply-To:
	 Message-Id; b=hdgpSn6Jot2zaKOCtlKFzlY7VUNtRf1nb2IJvRo0uCRLe+CM+269JmugowimvRCR1DB8sQAYbaGGo9+sn0J8tASklt+X4OE2HFsamZiOFH7BfWhkZfTRiHlDMh8PWbkjzZ5FA8Zf+bJkpSEWz7h0qOJsMvIXiRJKPXJDzAC/26Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=scdbackup@gmx.net header.b=JE1QU4Zs; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=scdbackup@gmx.net header.b="JE1QU4Zs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1790089166; x=1790693966; i=scdbackup@gmx.net;
	bh=AVR/T2D3/n5p3sYYK13kr7PUwRsZaI7QDFUlUNqFVvE=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Content-Type:
	 Content-Transfer-Encoding:Cc:References:In-Reply-To:Message-Id:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JE1QU4ZsN3FYq79tHni3yrgZvyoKhZoukg3Kv0n6TOKSimCMZrGwc5JKNareC7oi
	 dZXjlFL8Ui+P5T8yUSyF5gdSgONLNpLR7/QVrVAjJ7p1Vz+kegUaZ457GJBQeGJ0K
	 DNyjNJ0yRALCozYyg5rm4EVRz2sT5JRW6BskxLg1xjhnVTd4ScJ0e9KYbjksbGhjy
	 AqDsODix4H+XlsFzAIi9tgpS4fn4Ld3R/z2LuJubf0jcgv7KiIKIdghILlwpeplfa
	 wyD6EuGXyZ78NS0SKjbhm4cnSr+iOh6z3fF3S0HmIwzAmLDLQ6aM5MgwiHGYkpOFT
	 aXPapnJyBvC+oB3UZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOREc-1xP27H3cK6-00WuZs; Tue, 22
 Sep 2026 16:59:26 +0200
Date: Tue, 22 Sep 2026 16:59:16 +0200
From: "Thomas Schmitt" <scdbackup@gmx.net>
To: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] isofs: Fix handling of directories with tight blocks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: jack@suse.cz,matthias.goergens@gmail.com
References: <20260922121912.2258134-2-jack@suse.cz>
In-Reply-To: <20260922121912.2258134-2-jack@suse.cz>
Message-Id: <13424504872184120250@scdbackup.webframe.org>
X-Provags-ID: V03:K1:2WEErwIS5nG0Edhvnc8IFJmbjWdMdI29rq4p+AaotLaCUzI7ZiJ
 mrXWq8b2sLQbFt010gLBzgYbqXS+tLK5XmfvOOB4xL3kj3gLT/ovOqt+cLsEfUPBzZJ607O
 KVS99J9/8TiqzTxAX+yu6cK2HQhhLUsexn6QtAVDyj2XYgXJaCrnDDTaK2JYu+zkkI8PuhD
 GAshTxuBaWrZE745I50gA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QNXsR6Ay3Xw=;QGnTcOqt/TjzhA8yBcRvUSI3RMF
 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
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Hi,

nitpicking about a comment in isofs_find_entry():

> +                * If we are at the end of the block or at its zero-padded
> +                * length, move to the next block.

s/length/tail/

As unprepared reader i would wonder what "zero-padded length" is.
The comment in do_isofs_readdir() says "zero-padded tail", which i
deem more understandable.

As far as the program code is concerned:
Reviewed-by: Thomas Schmitt <scdbackup@gmx.net>


Have a nice day :)

Thomas

