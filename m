Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02870267AF2
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771052974; cv=none; b=g5pznTSbO+euKQKXbCHmq4ubPEoMt46pf2RB9dswoz7aJfdsT03+80y/3Y+vYj9EmJPE+aVEEpmAfg6WEMtBvJkixtBcOY0EsXciFRrf4LiEWzSbu0h/7d3r/e1QvM1U157PVrd5AD5GtkMIqDIhsggOdoPOJq4L14bWxOG2/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771052974; c=relaxed/simple;
	bh=DdXo9fpm4x3ctny2rjdCF+2L6u9rB/jLNpFlWxufnxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttyxfueP83o0d1XIa2mGWvJ0lrUcW9+q2LikuGzt+bQbSdquiIhtss3Nro42XKMqi9wqJmMRI/pOiY6RUbMewZpMOLnVeNCQSlmXF9nHibVBUc34ku7dYurYYp6CQ8ixoPFEiBGhVelbn9Ic+N9ugtOE+C12UTEcDkMH38+T8/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61E79IfA066345;
	Sat, 14 Feb 2026 16:09:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61E79Isc066342
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 14 Feb 2026 16:09:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f8700c59-3763-4ea9-b5c2-f4510c2106ed@I-love.SAKURA.ne.jp>
Date: Sat, 14 Feb 2026 16:09:18 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs: evaluate the upper 32bits for detecting overflow
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <37b976e33847b4e3370d423825aaa23bdc081606.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/02/14 7:45, Viacheslav Dubeyko wrote:
> typedef struct {
> 	int counter;
> } atomic_t;
> 
> UINT_MAX is 4,294,967,295 (or 0xffffffff in hexadecimal).
> INT_MAX: 32-bit Signed Integer: Ranges from -2,147,483,648 to +2,147,483,647.
> 
> So, you cannot represent __be32 in signed integer.

I can't catch what you are talking about.

There is no difference among e.g. s32, u32, int, unsigned int, __le32, __be32
in that these types can represent 4294967296 integer values. The difference
among these types is how the pattern represented using 32 bits is interpreted.
The -1 in int or s32 is the same with 4294967295 in unsigned int or u32.

----------
#include <stdio.h>

int main(int argc, char *argv[])
{
        int i = -1;
        printf("%d\n", (int) i); // prints -1
        printf("%u\n", (unsigned int) i); // prints 4294967295
        return 0;
}
----------

We can represent __be32 using signed 32bits integer when counting number of
files/directories (which by definition cannot take a negative value), for
we can interpret [-2147483648,-1] range as [2147483648,4294967295] range
because we don't need to handle [-2147483648,-1] range.

