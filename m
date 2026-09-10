Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BFD3DC4B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036149; cv=none; b=q25IiL/n7VbCvwRSY07bQ0vtaeWsWOpMrfhj1w5WOGGp5tl8B5KgkQg3RAHz84em4/2URK9Zns/2prgFBVDKoS2Gv/aNzohrUbaWsWAit7BRR15FI+CWZH8TsKdR6N+CTW2gHcN4eF+Q6mBZxGk7ChOyW1NOTzBXYmMQ8dSFrGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036149; c=relaxed/simple;
	bh=fG4ZByHgTSaDnZozQaNVtL4mEumsk/cA+K5V6+5iS/c=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=MDf3Cfu8zPjGZX5228L9PVLAzOcbytcjNJf8L71lQWHcPP5M55Eml9zlV6EEbdN+bw2vmpKdKf7YF+sq89xHLRP2//CUrd9OMYtUyipZYdxRj9F1PfLhY8Bwyc+xjbGgbmLf1ia64xnjS85yFxQDEIWQfrUiL0RjAJ4ynZevQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB7VIYuw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB7VIYuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71711F000FF;
	Thu, 10 Sep 2026 10:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789036148;
	bh=w9wpKBcNI8oIo2LzevKpSdubEEHD9UfUgHT+8xtygY0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=HB7VIYuwhLYRuJrKIt2uJ44FhwnsG0LExk5EFMhR2iko/B3N22eKusbcfbNx/pKdl
	 6cGZ16I29XmfkW9WZhU1vIxuHH89aq0nM6dpg8lSsD/OBGyOD85Pmw9ijOQvPT8OgH
	 sYtXc1I2Ezrd37zTZLTFbW3R8uU80iN8Co/2u4vO8xRYnQO5rgiqp5Xr7HRNcKJ1DS
	 DBH5KBabrfdHWf9sKS9FBrOThPAZeT1y7fSUf3qgsP76lG2p9YbDA8aWG4CG2c+E5Z
	 vc6UoqM42EtTCyyzzUXcs7MdhyAK/EL4zUxsbzTCBG7mJKBVbgJELNJcqnug6TuTJM
	 kzmoyajYzpZDg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC v3 13/15] coredump: add COREDUMP_CLOSE_FILES
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
In-Reply-To: <178900159210.207413.8292125177519817528@noble.neil.brown.name>
References: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
 <20260909-work-coredump-unlock-self-v3-13-04f907687563@kernel.org>
 <178899497961.207413.10554121774377911612@noble.neil.brown.name>
 <178900159210.207413.8292125177519817528@noble.neil.brown.name>
Date: Thu, 10 Sep 2026 12:29:03 +0200
Message-Id: <20260910-erbrachten-pufferzone-abgrund-a90f18bf5b88@brauner>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=606; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fG4ZByHgTSaDnZozQaNVtL4mEumsk/cA+K5V6+5iS/c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtassXzlmeenjq9vsMl76d2X7VrUQooonjXm/osgXT3
 q3wZVlS1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARg0WMDN8ElyU59rY9P3px
 nqWbS7a/lL27acTBJxr63VzvxK7E6TAynLvvrJ6+OzYyYoKggOX2NDXLXfvWXg3vj3v3rMlGuHM
 5AwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-09-10 10:53 +1000, NeilBrown wrote:
> On Thu, 10 Sep 2026, NeilBrown wrote:
> > 
> > And please - can "dumper" become a "struct task_struct *"
> > and have a separate "struct core_thread *threads".
> 
> It turns out that "dumper" is only ever used to get "dumper.next" so we

Yeah, I went spelunking and it was historically used to ensure that the
dumping thread came first in elf notes but that got reworked so it's
been unused for a long time.

Thanks for the review. This was really helpful and made this even
simpler. I've taken everything you commented on. New version out soon.

