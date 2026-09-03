Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB649F12D
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437223; cv=pass; b=AfVqxbtGQncnJqtZsKk86N4ojCfnmQoMWj8b9a5bN2yhsNA/YyjEiD2YZPNnB1Wyj8qzLE3IK4kDtkyGHQaxTzKDmiYFWvp8r0pjVooY0Vt7HBMuw3uRJdJooMyuv8FKFZTbBCobnaGOqpUGM1U0pBQ5D6SKtR/nzVGRqVdpPtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437223; c=relaxed/simple;
	bh=N9hcHMJS/8lnE6uQtyDcuSOjyISuIsi+YVlWMBbwn9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKsdd2LKUWzTOebbZnzTXI4Bv6fwXctcvTiTTn+5j9HxF+BZgWf+9guzGRA66cEB24aFaj66rmohfoiYuLhmC+luQUGcNYd2OX+5i+Uja6ZrRPAPH7AGr6NkxvlI1CdBPlUqV/49ZqLnbv6z+z6odifHQZTxJcY9iaRt/bV70PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l5nR44zl; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5nR44zl"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc439aa0078so1095651a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 05:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788437221; cv=none;
        d=google.com; s=arc-20260327;
        b=Z0Nh6jY76AQVePl94e4heTPgUrZ+QuZFNi8E+DL+/NkuFqlp1Ay7PWA++nKL3sLUEL
         5M/9Jj52voFWxAB0IQ2zp6PS8uu4hnMMfHt+NIXTfA8t0EfSNRZ7hQsLsEc4M5OFZaIS
         SKT50rDN8imkoYVpYAQ6IOxjJzb5B5ClUPiqyRzgX1lIPTEo8ZirhJJQWz6ZYWjSL/Xv
         T5fhfXz6r4gA3XB3oGi4ARQC9lzSl11qDTSpDVsRapq7N5nRFfruGyYSy9XzHCdR/+fR
         RFBqlPzJFibTUewLQakotQF1ThZHeNnrSf3a9u59pnKnegnyUTM2qJ4HWPrki5NPC/0y
         56QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=T7mRs8f62kLAbWPgFDhouIuEptLLIIkw44oKaw49xlg=;
        fh=eL7/TZaGWgXjmEa56qAoZjy5m+8opyzB8l/I6AxBxGQ=;
        b=Xd6W167FYak64DYD6zHPWFd9q08YHKcgwgoktih6qw1xmnpRHxnLOiJ1SCunkusu9B
         +WwnrFD8LTsfzsO/nOQS/LULS42syc5l+Z0k+QEUTG+SuuQps2Sm+/0inkBPVy+C1MyZ
         U45EcwhECNMnXBq8QY42F+wJNw8L2K+6BQ5un0SxZCzgLxF1i8p/HwiK1qVR2weFZ3l9
         PpkRAmFJOAdoZhzoP7WkvXRHtjQE1EkZc+E4c9i2C2/mOEvZQ40X3mXZgq+WJGaBt1jG
         CxlrcDtz1gQn9ZLoRfeanwRR7HfWRmePbpEK8kxcet603rKho+KDBynbh+YEe91RJ2O0
         IItg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788437221; x=1789042021; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T7mRs8f62kLAbWPgFDhouIuEptLLIIkw44oKaw49xlg=;
        b=l5nR44zl3xNW0KOvLvjUE8EY1mXbPtRD/yYqBlmVsGcr6n25HyQADIdD3tdCORtHgY
         P75Lwdzg3MI4MQyWBHggbiynQ6VxDBuFfft6N6tAEGlLePLoq++xZHFcTVs5HdgNg2jc
         tfAHIao66uK+n73EyyUw6jy3J9bL/G6uAmFaUXO7nmXm9O3eNKhlB4LJo2Ko3zOYu9FT
         UPGyexTbuUFP1hyGYYnZjMbz09jTwsm61Ry5HZkCLKK5egzpO8FNq5Vv/npodJ8P3Rc9
         /S8MuvabAa6g9UfS7Hy4/KAl4iku4NQkjRDEp+Ojb4LqeXoedJq07S7PSeb1VkV6IrDw
         06/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437221; x=1789042021;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T7mRs8f62kLAbWPgFDhouIuEptLLIIkw44oKaw49xlg=;
        b=JOwe5tDqxEvipc0DOMgHwccFuMNf0tMmyqYweSFCHk0btwfwBkZH1OWr44UF/7lYw7
         hcYmhRnM6hYiSBNnB+Sn3WyyxH9rK6/xftQRhhGZtz+35igI8SGY8t1/nIT3KeYzTBg4
         jK0QsJo32Yr4Du8vQNw7DLnFH8dpsG+DOQXRan4o3RvVOo2rOzyDG7Vm08EggLEDOvi8
         Tn2qKwZyX0P8UFiFJ6/ga8ZlylFDiJN+uV/RS/yKZ78ZVdAw7AtKFHrFjEQbsptCdq8L
         KwOI5HCQQFbVhQHZdaB+J1zlxAqHgWClh630Q/g1Ygk/IvwCQkdGnbyhqZHYJavk0WU/
         MB3w==
X-Forwarded-Encrypted: i=1; AKwUvBwBiU8zBjqGISyUx+Z3RkXGza3zp/p0MVLd0Ck39JerRG3w2J+WMMgWezMNHB47n0aKqe14pF6Uvv+svt8i@vger.kernel.org
X-Gm-Message-State: AFuF++khUOqeT7BE+PmAbJym+BSruRBS2dREA8E1NcGAKrmxRcwB2II4
	qN7LOMcK1S6HIOk42N1XN7auUcCq6EJc1X2sGkJsYYuTiUo5ad5BD2IqTjlXwNH48bXwu6yprb9
	u8/JiRX4afLM/cpivfVgm7beW77UmRvWRq0axy/Qk7u/RxahAsHYcOg==
X-Gm-Gg: AYBFou0NUniuhckZn2Mte1u6lT9aIwIy6o6NlBK42u3MRVLm2I+CjQLS+h/QRW565jL
	hVkl5DdHMiHT1Im0iETeMUTEPWw4ob9mLBUpHxhzltJk3RQH3Y/oAwarEBrul/k8e8zCHss7oWn
	6xkUOchjlRuWSYRwxdPU8N3Qk/sWXB/jHep3o/b+SJVlA7Q+j6v2sfFeIRCrrdbElPjWPUv6UxH
	9ZhAsjXJTul7DUH09hCYvw0B9DuVj1wczmx4yuH/IkEHyRov9INAxGQ/ZaniIsL/G+VTdlHVWg+
	cTZbk9TEKB6GGjdEQgBTBC1wKTCYzlAnoOdkHk18S6QYtusBDGJWPltMXfgKzZzisGELvYKTQvp
	h
X-Received: by 2002:a17:90b:2b8b:b0:398:ba9e:75ff with SMTP id
 98e67ed59e1d1-39aee12c707mr18887440a91.21.1788437220106; Thu, 03 Sep 2026
 05:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811160336.782342-1-timday@thelustrecollective.com>
 <xiymqvu5la6h63umrp6upnzbl3xjjcacuyxg76xp4labnrioyj@xowfpjlhfrzh>
 <20260903072759.GA1750084@ax162> <CANpmjNNWiX51UU064+P823sDX42=O6ChSHrUux1aNqLj60mfUg@mail.gmail.com>
 <hnmqtyjazturtmhrw5xh445q4vrwv2mldhhspl6sf4hj6yzvqn@vzje2tuhtzdq>
In-Reply-To: <hnmqtyjazturtmhrw5xh445q4vrwv2mldhhspl6sf4hj6yzvqn@vzje2tuhtzdq>
From: Marco Elver <elver@google.com>
Date: Thu, 3 Sep 2026 14:06:22 +0200
X-Gm-Features: AcwNN1Xhd1oZ_SfzBigtwT3XXDzSDHD70cYPowTnNLJ8nboEDZfHt_OFrhqa3Vs
Message-ID: <CANpmjNPBxfgbuyK1VWsCukurEzhR5nFg1ydwEP9Gt0sGm9p5GQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Support Clang context analysis for ext2
To: Jan Kara <jack@suse.cz>
Cc: Nathan Chancellor <nathan@kernel.org>, Timothy Day <timday@thelustrecollective.com>, 
	linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>, Theodore Tso <tytso@mit.edu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Sept 2026 at 13:06, Jan Kara <jack@suse.cz> wrote:
>
> On Thu 03-09-26 12:34:34, Marco Elver wrote:
> > On Thu, 3 Sept 2026 at 09:28, Nathan Chancellor <nathan@kernel.org> wrote:
> > >   fs/ext2/super.c:1149:3: error: calling function 'ext2_rsv_window_add' requires holding spinlock 'EXT2_SB(sb).s_rsv_window_lock' exclusively [-Werror,-Wthread-safety-precise]
> > >    1149 |                 ext2_rsv_window_add(sb, &sbi->s_rsv_window_head);
> > >         |                 ^
> > >   fs/ext2/super.c:1149:3: note: found near match '_res->s_rsv_window_lock'
> >
> > sbi was just allocated, and EXT2_SB(sb) and sbi are pointing to the
> > same object (unless I misread the code), but the compiler can't tell
> > since aliases can't be tracked through non-local objects. So that
> > scoped_guard could just become:
> >
> >   scoped_guard(spinlock, &EXT2_SB(sb)->s_rsv_window_lock) {
> >   ...
> >
> > But I'll leave that to Jan and Tim.
>
> Yes, at the beginning of ext4_fill_super() we do:
>
>         sbi = kzalloc_obj(*sbi);
>         ...
>         sb->s_fs_info = sbi;
>
> and EXT2_SB(sb) is just sb->s_fs_info. Are you saying that clang is not
> able to infer that sb->s_fs_info and sbi are still pointing to the same
> memory later in the function where we do scoped_guard()?

Yes - alias tracking is only done through local aliases. sb is
non-local, along with additional member indirection; unfortunately,
the C language doesn't give us the guarantees that it wasn't modified
somewhere in between, say after a function call (this rule is applied
also for local aliases if clang sees that they "escape" their local
scope via non-const pointer to pointer).
