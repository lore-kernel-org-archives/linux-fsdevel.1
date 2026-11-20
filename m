Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=131.179.128.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211665;
	b=YZLypYNA1E68dkhJu3+19+S20aiAbbwZmuajvD5VjvNeQsLGE88YyHDQBXcYyB7FoCud
	 CcTbg0hXavnMgEmHbdAmBNV5Sxd++wcfZx62dWZp2URiMXWOCgqcLAr4NqgPafQR/SejM
	 e4MEocc5ICXyVOPKxLyGeWuLhSd/9YJv1pzMMLhkf5w81dsKZtBjSHdB9d6zNJztK/yMf
	 cKbcv+Empxv6RDHIOh0eRxkGiUNgtH0J54nJY6hcNfjTNAxjowNFoioBUk/yz5kN11rkO
	 AzV/jNbiPDZ045AumXJ9ud0Ny7J+JR2923adJTL23fyGfe4j6Wu/30fTxoUbyf5CazQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211665;
	h=DMARC-Filter:Received:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=WoStj5ZyfUsSJQg9tyQmGQr55Y3sNNtMdzsmkonX61Q=;
	b=Ew0/kSQSNcNY35E5/k5pXd0i4gBz1PpmgQrfhluCwYBhL6pLjm6xhhqJZFS9Wgkb45wR
	 exeFjet2amO/Af68JnpKelNbCUdI0Mudy1z9JtqXQfBrNp/855K8UZPqnMrPoNYy9ETgn
	 8zwFwLEoG2f+TFLddT57Ad/gJsM6XXQiqOziWROazrZSu9ruTUkjUx+DQ2yNSTsjfsfbo
	 +ENKaP/LfXcBA7D7EiqlNKWGokVK2EzVLPcvOOTpbsSwgvhnqN/U9IPlFxG0/uiZiFipU
	 iHvDZZJnTr/G8dofIU9cP5tAGEnsc6CWJsHofhFz9T4hF+4YSzK2GQYQ3//vOoDlAyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.ucla.edu;
	spf=pass smtp.mailfrom=cs.ucla.edu;
	dkim=pass header.d=cs.ucla.edu header.i=@cs.ucla.edu header.a=rsa-sha256 header.s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C header.b=dUh1rAY8;
	arc=none smtp.remote-ip=131.179.128.66
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4A606A697;
	Fri, 20 Nov 2026 21:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDC4A606A697
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.a=rsa-sha256 header.s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C header.b=dUh1rAY8
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 20AB73C00FFF2;
	Fri, 20 Nov 2026 13:54:24 -0800 (PST)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id PonQXPRWpAkL; Fri, 20 Nov 2026 13:54:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id E794E3C00F59F;
	Fri, 20 Nov 2026 13:54:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu E794E3C00F59F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1795211664;
	bh=WoStj5ZyfUsSJQg9tyQmGQr55Y3sNNtMdzsmkonX61Q=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=dUh1rAY8mm1i5ZXjcyhb24veM7IQF/8W9bbqTwqFM13oey9+hWDS1DAy+mIxKzHcH
	 7/3r8c4I7BeuHS3AV9DooTIf1DPRlvZqSUCVUTBH6fLREAf7fvAmj6NqSCfDXI5t48
	 Jj9tFg1ZkTWVCrkoQ70skyE/fxdSCAONYEzRm7EXAY18HqOI/C7yoYu1FkIDi3PtvG
	 jWAGdjW86oYlE/HDc/GdZkQnyIc6A7djt2sN5H6uNmYYj2g2IQqmLqnjb+W1wNRN6w
	 CZMrnBcdIU9/g64tFY+Nd9zQd9V2+O66d+YsOnr2m3uhRO3Brn5goLGKxZcTyBBxHn
	 TeG/kIfpNSpPw==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id yPZ8eSIKXGvh; Fri, 20 Nov 2026 13:54:23 -0800 (PST)
Received: from penguin.cs.ucla.edu (47-154-24-214.fdr01.snmn.ca.ip.frontiernet.net [47.154.24.214])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id B74543C00FFF2;
	Fri, 20 Nov 2026 13:54:23 -0800 (PST)
Message-ID: <1e789ad1-317c-49e1-b631-39a80a24c58c@cs.ucla.edu>
Date: Fri, 20 Nov 2026 13:54:23 -0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: shorten I/O that would extend past the maximum file
 offset
To: Matteo Croce <technoboy85@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Ding Feng <dingf3ng@gmail.com>
References: <20261120184225.257554-1-technoboy85@gmail.com>
 <9cabfb96-21d5-46a7-a0e5-df0908fa67c5@cs.ucla.edu>
 <CAFnufp1ec4hDOoXCy_NdCEhkYgZzQktvN5RizyEkMQQ9MneRbA@mail.gmail.com>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <CAFnufp1ec4hDOoXCy_NdCEhkYgZzQktvN5RizyEkMQQ9MneRbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-11-20 12:46, Matteo Croce wrote:
> I can extend rw_clamp_count() to shorten the count so the range ends
> at 2^64 - 1 for these files too, so that the behaviour is the same at
> both limits. In practice none of these files has data near 2^64, so it
> would only be for consistency. I'll do it in v2 if you think it's
> worth it.

I think it's worth it, for consistency and clarity. (And even it's not worth it, there should be a v2 with a comment summarizing the explanation of why the code is inconsistent....)
