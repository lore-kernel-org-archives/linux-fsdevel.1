Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2EB390999
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 20:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073497; cv=none; b=MHYGhcld87HWnfNAxfORGB1MG4ybVYOj8GTAfW80+euQjIPXms7j8bqKogREwO5+IEXqhpYE88du0WD5swcheHyMHkNJfiogGGmgka1BotmXu70SP8kergW45rvzOSIgvws1NvI9kouVSYYAKr2SeLjYRmpLBVcj+L3rspjUdZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073497; c=relaxed/simple;
	bh=lQ1tC8QyyXsDWotGX0Dze7Qq9KJn6duOUqMRQ51l/t0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e0+4ajT30xT1UtXpiwPgWYrC5LHpnEh0OYdO4abrY1SFNEq3TCjrOxRi+1i0it+I6voJ4NTGyUEZHvp6nC27WdAOHxWH+QWeOSSdERPqM0CA0DhqxsOlO07ep9RIo7viPphPPbjCwYmwjBgeq18uHVKMgjN1VnY44iam9lQ7clQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=qyAe0Gp+; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="qyAe0Gp+"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4ab89cff9c7so133635b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 13:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073494; x=1789678294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GXMKHM4ByjQtPNS9X+R9gCOHk8uolkvlV5huzt/Ejg0=;
        b=qyAe0Gp+5MJD41P0biXsS+Tm0HKWVFusfBdr9lw1bFjum0QXINGToLWe3CtCYKJLzP
         mBCuIRz/76OmagJleXEv3Bv34AwPLVWb8g2XWC8qslvJ3tiUei3HkNC/2ZLl4qBipMdH
         qSjuY5eFLiqF1axrzdsuju/LUT05moIPnXAayc4h0Y+oGbqayjp10hSlr/iRIwyLWAWN
         Nl9nxWeW8LX7syvxrhW0/jOCeRrnsZA/x4bTf/mR8NJlgFsTKlF+5vKeEdBt1o46RLZI
         jk0llL/4HRqbWf0SK1oeMwc5YFrwyRUFB07A8lRQDQvmvP4V5CpDHShEiq0t27SDF4em
         MWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073494; x=1789678294;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GXMKHM4ByjQtPNS9X+R9gCOHk8uolkvlV5huzt/Ejg0=;
        b=Jhzeb+EWqms352FGRU4hba/sZ30wB1fRWNbOSME0xtQeFwm8xJ1P2gmt2KfEJ0/V9R
         L5wgui+UqQaa5SWl0UgLp1Ry+t65PtJ78Tmql5FQ7ZoxeP/3j9J8cUclF6GCztRZm3m9
         DLXNKtUBmJQveUU0cnvYmP4n1/Ft5gvKmFdRc7VRRRMrmyp9Z4cXe8mtuoRnLXdZcP87
         /N3+N4rS+etjfj2IHMdWDWk+bSaMbcL2rhjv98eyfgwSc/Vu4XxAdhoIebU5lP92ZxbM
         p6mHEJy3r35gm8mR4gbaobwzDwIEpVSU0y+rXY4NFoxCIpFk4o+/FoY9QMhp1ucT3iGc
         hkdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAP/lxj1hm5qIbpBijlPlkZZVNKFgIx6f/GQd5jh71jisHtfAyDa7Qa47gAtee6hknbJHt4c7BoE86vqnD@vger.kernel.org
X-Gm-Message-State: AFuF++lOZ7KTHQuwKoVmaZGOW9EcO95ty2RJfGsDznD8461T0zjMzRFJ
	LKuuXv8IUdk3UcHIC7dqnNhXxKRJtMxGk/IhnzxXcuBLmysP4/JcTbT8XCMeMu+p1hU=
X-Gm-Gg: AYBFou2OlEdr4SYuVUglJ9pOp2S31QUkVo6Ci8Ib5RbbMz6cRn2BtVhInF5GFnXeTic
	GiKKE7nuNkVvOHbBiX/pmveAKsFqTgfwTgKVtIVac0gCeqwD70Qm/34EWfgLAyywZeGY/M2CG+7
	L6UDjJYRLfojJ/kqanqIatRUci8/81ZXOfaftR93FXTfoAsaXquqiwlQKFMACDjk2NCtBe3+O+p
	qxEoJW4zWm6FJTdND517wVyWkSF+34eIx/Sp+jZQzbFk+8t8msepej+X7tIcm8MOt648tnrBzIJ
	S1Ai3aBnFF7v00bZmJ0pVWJ7ynehAvRmTgqDnQUQUPkl3qg5NE6hXhnQ7jG5Czpque9pVf3zLA0
	iOogjPOq1nNXqSqgWjKogykeu/QTjWe6Y8wz9r0ZYdHFK9QIs0hsHx+fgl04IwLVQ361FLBOQxc
	Hi8lbJ5UrJsFMRTwGQozT8agM67DcZIwriCUucrqV8ght+gEkju06dVRr9riEpcgimLO7OZ17av
	BYrRvCEIs2iRPgLUtMGfo1PvNyzkdKfRk7UVBCVNFlOUBUQEyqMLhyU
X-Received: by 2002:a05:6808:1a09:b0:4b9:a88b:8895 with SMTP id 5614622812f47-4c31cf44127mr554822b6e.43.1789073494540;
        Thu, 10 Sep 2026 13:51:34 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c330daa69asm282875b6e.5.2026.09.10.13.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:51:33 -0700 (PDT)
Message-ID: <cff350b3-836f-4953-97f3-d664164746b4@kernel.dk>
Date: Thu, 10 Sep 2026 14:51:33 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lazy bounce buffering for checksummed reads v3
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>
Cc: Tal Zussman <tz2294@columbia.edu>, Anuj Gupta <anuj20.g@samsung.com>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260909060924.1102037-1-hch@lst.de>
 <fe537c5f-114d-4d9a-817d-93f359e12924@kernel.dk>
Content-Language: en-US
In-Reply-To: <fe537c5f-114d-4d9a-817d-93f359e12924@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/26 2:50 PM, Jens Axboe wrote:
> On 9/9/26 12:08 AM, Christoph Hellwig wrote:
>> NOTE/QUESTION TO SUBSYSTEM MAINTAINERS: The patches in this series are
>> split over 3 subsystems, and I'd love to hear from the maintainers
>> about their preferences for merging this.
> 
> It's a little hard to split as you have eg block patches both at the
> start and beginning... In the spirit of getting this some runtime, I'm
> going to queue it up in a separate branch,
> for-7.4/lazy-bounce-buffering for now.

On 2nd thought since this already relies on stuff in the XFS tree
apparently, you can just add my

Reviewed-by: Jens Axboe <axboe@kernel.dk>

to the block patches. Would probably make everybody's life easier.

-- 
Jens Axboe

