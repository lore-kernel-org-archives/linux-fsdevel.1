Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47AB44CAC9;
	Tue, 16 Jun 2026 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624189; cv=none; b=lqzJOonOupfY+bEXUDPtNnUwmlG1OWw2GUGhhdN0F45ySyQ7Vns5msnxysSo/L3QwPf2abeb7qWwQdVPkKhtlUVGIJffnfjO08sQXpF2WeuksmpQeT2SpM4Rb75E28IxS1AObrM3dBKVExG2h3OCQkbkel41l20l0vK8nZzJQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624189; c=relaxed/simple;
	bh=WJtT2JMy7K/r25U7qyyOi/+xRZcewR+ULO80REb+UXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eW6rBzyjK36s7dn5HEIcuDuocHfJiiHnVmnd84kq4b9/1ZY1qPLHnl/WcpkNUBM7u7LtECPJi4rG2SQnU+T0GRvCP2s1tRPVCODXYADh5Rtg1nqDgWl0iY6WCInbNGEJo4QmnPBkztEfxYcX/32fpOsiUCteUAwqZkIsoslvKPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=SPEZ9aEa; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=xeGBcJz9; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="SPEZ9aEa";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="xeGBcJz9"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 8ED5826F768E;
	Wed, 17 Jun 2026 00:36:25 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1781624185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lhoq9fcB8D7p3SXbwPX5T8PS1zHqnyK+nN88K2RQN4=;
	b=SPEZ9aEa1NaNOFF2eZGxs51oqY6DgQTk43DvgQATGZMUafsk8iVZB0OFI6EXV6vHepGsnG
	az1p1izTL/vPg8wBo9GJ3C2kpOfFbTLjENqFC/4l3pu1KcY4yK4sQzpcbG3FxDbypKXX6Q
	b9ZN9BxhN8JK2e/tL9JahetkNXBq3h6yELSaTobQqYRb6UHQPEzougKqhOeFkv6LgpXMm8
	kO+6pZueMIfT6OU20+RZJZLUhVK5Hh+hmj5SEb9fVnQSMW5KmjqaDUfBgWOaDBKDitqzUV
	WskjkUKzqQ/l/gwCkAV3nUB+FmQPvTGneiAYj8YGpkgpiWxxZj2JP258j6J3oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1781624185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1lhoq9fcB8D7p3SXbwPX5T8PS1zHqnyK+nN88K2RQN4=;
	b=xeGBcJz9pwCwQP08i7Z4uK3U1QPG2Y2CG+QJ35tTx3yiTwKlYaIPZ0+pxWTMs0pdjA3Fql
	drixvPzk5Z5r+OCw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 21164E003B8;
	Wed, 17 Jun 2026 00:36:25 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 0FEC922000BF; Wed, 17 Jun 2026 00:36:25 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matteo Croce <technoboy85@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Timothy Redaelli
 <tredaelli@redhat.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH v3] fat: stop reading directory entries past the
 end-of-directory marker
In-Reply-To: <CAFnufp26AYeeDF9Jv8_oG4q5FG=D1t-WXE0qGFJK3ozatnq79A@mail.gmail.com>
References: <20260613172816.18034-1-technoboy85@gmail.com>
	<878q8e699i.fsf@mail.parknet.co.jp>
	<871pe65ydk.fsf@mail.parknet.co.jp>
	<CAFnufp26AYeeDF9Jv8_oG4q5FG=D1t-WXE0qGFJK3ozatnq79A@mail.gmail.com>
Date: Wed, 17 Jun 2026 00:36:25 +0900
Message-ID: <87v7bi4hvq.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matteo Croce <technoboy85@gmail.com> writes:

> Il giorno mar 16 giu 2026 alle ore 16:54 OGAWA Hirofumi
> <hirofumi@mail.parknet.co.jp> ha scritto:
>> I re-reviewed this part. Since here is failure case, so we have to
>> release *bh, isn't it?
>>
>>                 brelse(*bh);
>>                 *bh = NULL;
>>
>> >> +            return -1;
>> >> +    }
>> >> +    return err;
>> --
>
> Oops, right.
> Can I send a v4 or it was already merged somewhere?
>
> Thanks,

Maybe it is not merged yet. Please send a v4.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
