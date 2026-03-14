Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953B2335BA
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Mar 2026 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773494674; cv=none; b=eJhVJygVthX/W29siXIM7vkoQygaYldUjFqq/Zupda+WqdiV/wS4/o8vIv6AluhXwuiivWBy08DB3Q1Kz6DRQxHTwz9mCAj03dD9pY9ml6modBPwIC9ByN/zU713nDdCGdMeHvjX1A+k/jfPQfaABRK8m9JjRIg+VM1oImiyTjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773494674; c=relaxed/simple;
	bh=2F2RbXFwqMUwFfvrjLLbOaZLEYIz1Yugz7wYx+tfyWc=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=NUOtSBg3AaNfQV7arKZbj2knjWGTyLTA/bns6XpUy1nR12V6SFIFG9xZcX7nzO/p4VUFyE5fasgDH7Gu/l3k4ulONeE+9IfrbCwMpVHwJ9nDS7QY2etnrNCeRPo1u/ttoPADveQncdhul0j6DXcRirCAblBrlh8aRLKf5NOzwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=arfurJQH; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="arfurJQH"
X-KPN-MessageId: 1ddc5e77-1fa9-11f1-bea1-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1ddc5e77-1fa9-11f1-bea1-005056992ed3;
	Sat, 14 Mar 2026 14:24:23 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 1deb4405-1fa9-11f1-b5cf-0050569981f5;
	Sat, 14 Mar 2026 14:24:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=MoxVSMQ6n0rSRi/aWgDb9fg47+Lmhlr9u6zK5MTyGnU=;
	b=arfurJQHEPNEt5W0UrdoA2BFsMYC3/ChehquiivKYkHkwkhqdpADqL2xSxZL6+/SKXo1QaRUAsW3Z
	 zxbDMrgz0n7AlbmRcjHr0LdOjEolJHfXQ3hzx83wqZI16s2B7QFHF5ezwHJiL/aNibqk3bqox/RyLy
	 dD2ovRcLzxBJ9r9tKA6wgBmPeCji3yPujX0SDcaa9emCNxmH12WY+AN6rzmpssRbVrZI9TjFL7pD4O
	 39tgZ4GgjNKGPcZuVswfoQZ8sSzviycl8nmcp7lyUeT2GaCbEt6nwCVHowe8TJsnbGmdo1pbkWXdi+
	 1RWhdNTdBlpSFAlIaBguEs1zxU3z5aw==
X-KPN-MID: 33|AxTP1D4s3VVK2KSb29UjO1CECxMKmvkEO/Z7952fLXob3R0QSR28+YxkOdnCfHp
 XRZ3V5un4DcEixFpyqpI0ORs2E2AhXgdJzbSik7W5p/0=
X-CMASSUN: 33|y5kk+sJiD85yW8ovQcEC3OUEc8MQoj0+Tj0yNK0yU5kleUug7F4Mopo4ZHWP5RL
 sGslPrCdkrp1iti81AiZlrw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 1dbedd85-1fa9-11f1-b8d7-005056995d6c;
	Sat, 14 Mar 2026 14:24:23 +0100 (CET)
Date: Sat, 14 Mar 2026 14:24:23 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Message-ID: <1046306323.1691628.1773494663411@kpc.webmail.kpnmail.nl>
Subject: VFS minor improvements policy
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

Hi all,

I submitted a patch a few days ago about fixing the docstring of hash_name().
This is not a reminder of that patch, but today I came across something else
in the VFS code, while trying to implement a mkdirat_fd syscall, that I thought
might be slightly improved. We have this anonymous enum:

   enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};

but it is also used as an out parameter in filename_parentat() through int *type.
Now you have to look up what this int might hold, so I wonder should this
struct not have an explicit type that filename_parentat() uses?

However, my question is really this: what is the stance of vfs maintainers/reviewer
for submitting these kind of patches? While going through the code in more depth I've
noticed wrong/unhelpful docstrings here and there, and other minor "issues". Now,
Greg KH has taught me to be really conservative with what counts as an improvement,
for instance to not sneak-in white-space fixes in a patch.

So let me try to be a bit conservative, and just ask, what is the vfs stand on this?

Thanks,
Jori.
