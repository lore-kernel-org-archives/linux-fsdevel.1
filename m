Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.92.8.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580512;
	b=3m9kT27wh8ucnG6t6v0EMosFz3uFu7lAusXQ0JHvYtoXFa5KBV/FxymJGrTU/PD6yt3/
	 js9sAGHCXFLzp2TwqtGn1SQVyqRtyO89PASy6kt5RK+l/XT6I8Cw/CDUkg7yqmN7pVjqp
	 0KvXRMAJPeOJWsNTeij/KS56nL1sBPvfIvxLBzgu5H/swQuz9dGaB2gQwPWlY/ykYqRGM
	 O++sTUpQp3Bs9YdfjL2x0a4dl5TGnYz9/p26PpjlWIDT2mSvjQDF1WipHESzRO3uwacuf
	 v4+h43W9YOP5k2AHCRnpa0Pj582SPIZN7aUkAUru9NAkhScV9JwbFkTkRbCpbXrEyTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580512;
	h=DMARC-Filter:DKIM-Signature:Received:References:In-Reply-To:
	 Message-ID:List-Unsubscribe-Post:From:To:Subject:List-Unsubscribe:
	 Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=E2qprF6FdVgTBcDTZe2XJmFw04za9FQ5JpaCXYKpPbQ=;
	b=WVgzS7W62DryiPA8ggpYLRVyoFrPfB6WksjGjnY4aYb44asqJn/RDojCtUUxpypFWMMB
	 UbzmppS92rWqq0JhQzEXf6xEmHuenYcCKquZB+drmqwTaS+409eNj47f4RfCTClV4p+um
	 t5FiZa3Gz2o+x3zONiNHm8WRX/liWFx/KAZfNQNocs8kZId5iYvR5vPz3gGbgGxMqE7O0
	 EszZ1KIiZm3Ho+yBWqcn5kmukhSEq1NUgH9Fx29Y9z5dtO9vAGT57YkzKeN4oViVsqG5I
	 g0aA/LkvtdNXJT7ShEL6iEy00ZCWMNZASoVt5cG8Yc5vy+HOOdSuSHiO8BuhbhSJpuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=planestimations.com;
	spf=pass smtp.mailfrom=planestimations.com;
	dkim=pass header.d=planestimations.com header.i=@planestimations.com header.a=rsa-sha256 header.s=202505 header.b=M8Z95ZQ1;
	arc=none smtp.remote-ip=45.92.8.66
Received: from mail.planestimations.com (mail.planestimations.com [45.92.8.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84D606A31F
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 11:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A84D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=planestimations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=planestimations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=planestimations.com header.i=@planestimations.com header.a=rsa-sha256 header.s=202505 header.b=M8Z95ZQ1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=planestimations.com;
	s=202505; t=1792580502;
	bh=E2qprF6FdVgTBcDTZe2XJmFw04za9FQ5JpaCXYKpPbQ=;
	h=References:In-Reply-To:From:To:Subject:List-Unsubscribe:Date:
	 From;
	b=M8Z95ZQ1CIcoLUMI3cuQ7GGRiWiUlHKxO0vMMb6NAkICs+jYDAIPmzhWpEIXy2duF
	 EmB1xmzcNdORChXaIYBQb9qE8YrzfqNtp1lkHXmta+GEXjfJls2yGpzPvCVaEB8S8Y
	 ebrPIRqYZIWUOvB/R8bSP6tvjMYDGqnSZxNKvhLH98zf4y7LGr/mdjC0MjCF4k/th0
	 O1WZEJz+XQ1RoDPE+UbdcS5h4yQrb7+2Qm3N9sRGteKcfG1+ny8QNxhH/hEOpEBQ3M
	 PJPJofA8KWQ+MWdF5q+sUanbkVh/nydePY12Ozqk39eJcVYFXnz5Heovv+bCI+wUZc
	 4J4JE1LmsV5gw==
Received: from [127.0.0.1] (ec2-54-91-165-133.compute-1.amazonaws.com [54.91.165.133])
	by mail.planestimations.com (Postfix) with ESMTPSA id 3663E5015F9
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 13:01:42 +0200 (CEST)
References: <c25d4d3c-49d9-4c82-b40b-81a11361ecdc@planestimations.com>
In-Reply-To: <c25d4d3c-49d9-4c82-b40b-81a11361ecdc@planestimations.com>
Message-ID: <91deb3c3-0802-4075-9a08-6674c825464f@planestimations.com>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Jane Wells <janew@planestimations.com>
To: linux-fsdevel@vger.kernel.org
Subject: Precise CSI Cost Takeoffs for Your Builds
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 11:01:41 +0000
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi ,

Just checking in in case my previous email got buried.

We support developers with accurate CSI cost estimating to help reduce =
bidding risk.

If relevant, I can provide a sample estimate so you can =
evaluate.

Feel free to reply if you=E2=80=99d like to take a look.

Regards,

Jane Wells | Sales Representative
Plan Estimating

Click Here to Unsubscribe
