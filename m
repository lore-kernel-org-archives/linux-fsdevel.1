Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA883D3D09;
	Fri, 10 Jul 2026 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669940; cv=none; b=PP5VQ8Ja3Uvt96AzqKyW/GV4SNn2u3aYXgIb35CIQ/KEMk0rjGM3b3jTcmHXnZKnzJ4n+wclTtDOaVe/SmC5cCpEZt5z/ecN6VPzsuBg1XLTlvyccB9mkM+TnfQ3zg2XOe/OBp0LBdx3wRYhXgumdn013cFgmNcIJq4XyCgFdSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669940; c=relaxed/simple;
	bh=uWmsIYTRdAY8EC7qmdc94Rh0bih6B0GWRiGI+/a4cd8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Hv4dMfmKj6XubNU968IERYNAw8X/KWsW+YbIFDopqeGHCOWUg3Mu5ttifM1VWBG2Q3LsV1Rn6bWeeE82RWvkBQz/2JK4pYBrOKtQQA5DDf8NfchHWjibRlMzCPqhEgxXjEs/iuk+CPdEa67smj6nc7W5XjuKDUjxG3PMu+Tca7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vFu9oHCh; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vFu9oHCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783669913; x=1784274713; i=markus.elfring@web.de;
	bh=1Iu00rCKH+m4f7RYlDaRd2j210yRjvPsEnyltwIPMSM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vFu9oHChJ0QukYplHDxsJcfFpWWsHCrCoDtpIFJ+IddPgfQbMss+MeRnwpb4WQJY
	 uR0sQAWZGA7htAOzINrDfsW5yW3Toxx2AyTdjaEnxzzktxyeiMbgcEmt/tNAddTaB
	 +ESyuHGnczuv29Rl9qbrJHHIWqDcpoF/8PLksplGhFX2ngFhSeQJfuV0UWFHVB5fQ
	 6TnQWL42nHLG+Nb6oq1xor8qWUr9sYIqn0qbADncSTOr0dQ9fgoihJ569oxxfyL2Z
	 LKjfFDXqmfYiacMrPPHbuY+iqCtN6Nhg8tVseXPNEyGfZrslEmjw/+b+BVUIqpDRs
	 VAqUZBZebrgSzc2psw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Gkg-1x8wY73DNq-017FgL; Fri, 10
 Jul 2026 09:51:53 +0200
Message-ID: <222b41c0-24e2-4ddf-b323-3c81403e3603@web.de>
Date: Fri, 10 Jul 2026 09:51:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yi Xie <xieyi@kylinos.cn>, linux-fsdevel@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Chuck Lever <cel@kernel.org>,
 Jeff Layton <jlayton@kernel.org>
References: <20260519010140.37251-1-xieyi@kylinos.cn>
Subject: Re: [PATCH] exportfs: fix error handling in expfs.c
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260519010140.37251-1-xieyi@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3cWkmXS/N9eKhEZMX1rH+XW46yjeKoQLCCcL7cD+yTW+csJ5Ilr
 YAd1UQzVukluE8Bvl2THffP4Tvko6vK3kCRQMTDsMbkJv0/A6eEnxODf9VWGvnAabq9OE1V
 zNCB8KOEc3uZ/2hEJcvewYvFzwAjjCyIc7M6f+uWVfU/N+eqlLQAdM9MuUTyyfHpcNFwmH4
 T2lFsj6tffpPsDo3KDQBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NJDkla4m7vY=;Advy51a/nlRI3FMi/7k5bjB/95b
 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

> dentry_open() and fh_to_parent() were calling PTR_ERR() before
> checking IS_ERR().  Drop the redundant sched.h include too, cred.h
> already pulls it in.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.2-rc2#n81

Regards,
Markus
