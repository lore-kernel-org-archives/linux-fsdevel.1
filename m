Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366B5442360;
	Mon, 31 Aug 2026 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186333; cv=none; b=Nn65YNAi6Onky5tdkOWN+EZleUK2zAqo41wk74+rPge3HqgHML2UegFKL+hoLcdZnW2iowNc1TRw+2EX7ENtOVtVP64zgd20QDl4cIRySrzZN4JDhXMsbhYP2wVFrlig+uJbPIq+IdFQXw6y9McFVqxYlga2WhxBIcjZFAGCBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186333; c=relaxed/simple;
	bh=FOWmjPwhcPnfsgfybQqGkKOTxzWrKcgQBsXz1d3DW9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cH/7duMqEhogpNRGdN8O92BfSrtuq2n4BXIviDjJMvxDuEb1LlkN7dhoFSfydXfTlhG9hCGBlRkSLIMZCUPWJW0h3f/iRsNwCXSpchy/U5MwouN+RrrbDrqsa14KcWj+sIgGbCX++e9ha02TumTYty8E+zCukLZ5vsN3B22Vj1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=2XNVH0TS; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=yRNdWvHU; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="2XNVH0TS";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="yRNdWvHU"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id CB9A526F7696;
	Mon, 31 Aug 2026 23:25:21 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1788186322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kAoMtYbkNNUiOE+S3UoOomnsFSBHMhruboJztWKQtRk=;
	b=2XNVH0TSwxbuOqnO7Qc9NgluT0PlhsHRR02nJvBatSWeIhTW10czwY9an1PVCu90WnXyAK
	Klwv7RWnRJaC9XIC+K53X9+UM2FCWt7Zpji/ULnWaCFacjbl/HswvfeB7ZNmW+Ey2dq2jg
	yuTtPowRNOYsHDUmFeIAk4jD5X8XkFQZ0BKYhxOOV7NKEfspxbuMADnXNGMZnHOD+6bDpI
	qoI0Bmz+ZE3QSYR8nsZaS7StDUUnrHLITrYUiemqfGv3XFRhqQ9Gp8prBgRmCQAAF8f8+8
	Cv0ntJZrQLm+sf99XXSznHAqL5TzrvhadaQYWrCzOo12wiovhfCjRZYk6NfF8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1788186322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kAoMtYbkNNUiOE+S3UoOomnsFSBHMhruboJztWKQtRk=;
	b=yRNdWvHUn8XJbByLZNn6klCcVnWASFsOsxSmkNAb3IizEdGRK34dSCpR4Ci2tpMUKuKQpj
	B85RtEgYcydBKOAw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 579B3E00161;
	Mon, 31 Aug 2026 23:25:21 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 47DDC2200164; Mon, 31 Aug 2026 23:25:21 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Jan Kara <jack@suse.cz>
Cc: ZW Tang <tangzw515@gmail.com>,  Amir Goldstein <amir73il@gmail.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [BUG] fanotify: WARNING in fanotify_handle_event with crafted
 msdos image and long path
In-Reply-To: <3kzvlb3wpzbg6k6ttzp6rh2cfmz3hmmmlisgxjn5u4xmaaqibm@qkre7flkhejl>
References: <CAA2SOT5mWrS_KN38TRCu_KfTjpG6fyaytqZbOb25Pb0kfqZ3gQ@mail.gmail.com>
	<3kzvlb3wpzbg6k6ttzp6rh2cfmz3hmmmlisgxjn5u4xmaaqibm@qkre7flkhejl>
Date: Mon, 31 Aug 2026 23:25:21 +0900
Message-ID: <8733vuweni.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Kara <jack@suse.cz> writes:

> On Mon 31-08-26 12:32:57, ZW Tang wrote:
>> I am reporting a warning triggered by a syzkaller reproducer on
>> Linux 7.2.0-rc3. A similar issue appears to have been reported upstream
>> before, but I can still reproduce it on Linux 7.2.0-rc3 with HEAD commit
>> 1137d8b5df06137fb49513cc923b3b24d94cb809.
>> 
>> The reproducer mounts a crafted msdos filesystem image, creates a very
>> long pathname, installs a fanotify mark, and then calls execve() on the
>> long path. During execve(), the file open path triggers fsnotify, which
>> then calls fanotify_handle_event(). While fanotify is constructing the
>> event, it hits a warning in fs/notify/fanotify/fanotify.h.
>> 
>> This looks like a fanotify name-event encoding robustness issue. A crafted
>> filesystem image together with a very long pathname appears to trigger an
>> unexpected name/fid event layout, and fanotify_info_copy_name() reaches a
>> WARN_ON_ONCE() path. The kernel should probably reject or truncate the
>> event cleanly instead of triggering a warning, because panic_on_warn turns
>> this into a kernel panic.
>
> fanotify complains that the name length is greater than NAME_MAX.  If I can
> guess, the problem likely is that the msdos filesystem (vfat?) allows a
> file name that is longer than NAME_MAX. Which would be a bug in the
> filesystem driver, not a problem in fanotify... Ogawa, care to have a look?

A patch looks like be applied to v7.3.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
