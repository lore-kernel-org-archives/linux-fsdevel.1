Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960753D3328
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114542; cv=none; b=IHQjq1ApTmj8QMO5gXJHxS64HBNO/M2sjA9TpkgwECl3Jklo5/m5qm4/q/VFQd/YPjbPAXaN+Xs+H+aSVSRHfHsu0EKRMJ2pn6h2Tu771H8f34eKDgVQ8maH/n9s3KJgW6DDanU33fwuo0eQ6EB6zBqTemqc1yeT6mxpGbbInZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114542; c=relaxed/simple;
	bh=Dgy8lnG9ibb9weBBNmiRKKijIXpaU0IVOTiJhb7BJEs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WUFnxx8D7bAcCOGEda1n5WqIf6P2/0wOQ+LjSLwn14jbC59e5vQ/jJ/ImcFined2UEufvQsvdyjZgJUYDX48xPtfvObOjOXBj4StEZrvhvt8OTXGuoUYhXhpLp9HlIoyTRLAO1Iw8yR8PISDS1u+XoxUZQlKwMi5DLiqM4wPFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61QE23G0014721;
	Thu, 26 Feb 2026 23:02:03 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61QE22Gb014718
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 26 Feb 2026 23:02:03 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0cef4eb7-987e-4fa6-a5b1-a64c5db1f42b@I-love.SAKURA.ne.jp>
Date: Thu, 26 Feb 2026 23:01:59 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: don't fail operations when files/directories counter
 overflows
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <6e5fd94e-9073-4307-beb7-ee87f3f0665c@I-love.SAKURA.ne.jp>
 <68811931931db09c0ea84f1be8e1bdc0fd453776.camel@ibm.com>
 <4a026754-1c58-40a6-96f9-ecaafa67a2ae@I-love.SAKURA.ne.jp>
 <62e01a3505bca9d1e8779f85e0223ec02c24a6de.camel@ibm.com>
 <ef597d09-0fe0-44bc-93ff-b0223eb97ce8@I-love.SAKURA.ne.jp>
 <37b976e33847b4e3370d423825aaa23bdc081606.camel@ibm.com>
 <f8700c59-3763-4ea9-b5c2-f4510c2106ed@I-love.SAKURA.ne.jp>
 <40a8f3a228cf8f3580f633b9289cd371b553c3e4.camel@ibm.com>
 <524bed1e-fceb-4061-b274-219e64a6b619@I-love.SAKURA.ne.jp>
 <645baa4f25bb435217be8f9f6aa1448de5d5744e.camel@ibm.com>
 <a6e9fe8b-5a20-4c01-a1f8-144572fc3f4a@I-love.SAKURA.ne.jp>
 <fd5c05a5-2752-4dab-ba98-2750577fb9a4@I-love.SAKURA.ne.jp>
 <be0afbc9cf2816b19952a8d38ffb4a82519454e2.camel@ibm.com>
 <15eebd5d-cf5b-42ca-a772-6918520ff140@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <15eebd5d-cf5b-42ca-a772-6918520ff140@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp

On 2026/02/21 10:50, Tetsuo Handa wrote:
>> We cannot simply silently stop accounting folders count. We should complain and
>> must return error.

Here is an opinion from Google AI mode.

https://share.google/aimode/VTH5mHPFmaH62fnwx (Expires in 7 days. Please save if needed.)

