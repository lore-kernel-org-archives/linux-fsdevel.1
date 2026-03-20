Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A591D5CFB
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 05:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773983561; cv=none; b=D4ZqVLkWvz4XockMGb8zgYar/n/TeFG9fybLU6x2uqYnBA7UAJ43uWYo+1FaQbrQW/tB8eQABa44AADJ8vT0nY5cLTAWolqLHGyRWxJbTXUtwoSSxJ5FcxrhXWM0+9IEh8/ew5gN0j5lxlXsB8mkGmeBzAZ9m3DAqhanaF+ma7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773983561; c=relaxed/simple;
	bh=EVxsGF2JMx78s6vGfm1dnPsILWqubQVs8xjak0z7u3s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IKjLZ1xvFJWdo1PIOhX1HdXPeDoqRhzYQTr2/9V+K+hIkz4e0RBnJyP2fXwp3a1nHjAbgxIRpEwe9kwUXh6HPhDKQV9NAY40ezxgpk01AZiX5emzPEAcX7uYv28kXsEum9P44zVvDUUmhcmL9Dynibt+wyrQtY6ddWjCzjvjEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=VBhUMb41; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="VBhUMb41"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82a87ef7304so446237b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 22:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1773983559; x=1774588359; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG7jjdThjpAvZ3OM3fiIAir9QVeVGL5dlO6ES5/Ehv0=;
        b=VBhUMb41Y2khI3mcpSlI7thNrVoNDltaE6qBpsqMQODBxPyUvbTDJUmkLz6rlvW2yq
         4mnX1hR/Ox8iW3FiCvs665zq2lV9UJv6aKYPS764dW+yp5JdRJ2LSJlM5UDCuE7aqdqD
         8YjxJTZaafv+xbOOUsrVdv8aLaY5y8q/Q8u4ZHtMGKntfnxwdchtdyhcKfzmosbt0bN2
         nZS9Ceql7xRP09AeD6p6j8ekNLTeLnfNcQpc79sHuJnaU9EeNwu1fJl/zo9dhHHCiZI6
         CDwnIvKJo+tJMrAL3oKCP84RhHkYp6Bp7p9W9Cib2mPwsx/iTmtUiqUTsmOvBNHetx4O
         Gd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773983559; x=1774588359;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rG7jjdThjpAvZ3OM3fiIAir9QVeVGL5dlO6ES5/Ehv0=;
        b=LhNtKEDBPa9QnS9q/U+jGWowGb37LIRP3QISNA6c+74IjfjFBb3ZwjgKlWvZQtrc/g
         2ElxTB8UsbarmX8y/hp6CgNz1E3RixFWB+ZuZ6d7gsNrK8iXRgwD7asFRm220KQlJR+G
         C7o4DdNdHSZztW7APFGwTdiDOcMPGKfGz7agoGrC+HfqPxdAy/gPZ4w/06xkFYbJNOEL
         gyQnihQ+TEOmty3LrQVrpK215119FDg7f48+5yWHFLrR3pdRE9sZ4A0UPqxn5ncVVstR
         Zhtqa23IFHRy3H29LGj8jWIm1AZu/T2wXf43w0tS07Fo8p8QmcC30FZpQtMxH7tKi65E
         fIKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaOU+BWIBcMRm5MNLybZUxqVDQWPMtlzRUGwNescqcH4nVfdATWQFiLAX4vVoK3c+kzgmXLeVufGB9ZFhG@vger.kernel.org
X-Gm-Message-State: AOJu0YysYiBvcLmH+1B7ZMe/6fBj7a3mmWHgdVFNmDNJ7JKSRFWJa2P3
	7JasgWQNJLtRDzReow1hxAuId4mzXolqvqWzcm73ygqCitPHfDloHf7fII5A8Wf0JB8=
X-Gm-Gg: ATEYQzxPoZVhUEbhDVlLWF9MukBFgajUFMweBbbpB8XyMRAPaLb09o+ulmzGeFdSfLa
	+lpDwIsYV9XliYTF08JlRVyDYz5Z1f+32n2o3QEMEaoqDTLU2ngL56VX2WST7/w1f/NVxWbMDSf
	eD2yHkIjEL1fscp40kq8dh5/LmKDhUvvRgl1+L6tsw56hSc9Fpe+scecfeXdi+sX1fzWIbWT0W4
	3GhMaWu3xbZMmPFYU/Emyj9kpzlP9ISUL4XDZUtStCvSazCppbla5DysOXQHHzyFnb0d9ut0BMn
	yRzXoF3UeW3JcHaT+PePea+oNVF6S8kovb5Lmj58qBIyhNQM3roRhFiYbuhWPgJRaKO34javwqn
	ftalJWHrDN+HD3bL0rj8xzc4NRkNDkh09vj91nli7E+4Nmpwth4NM0ghXiWFzCI2+hYgxOAjTAR
	JfgDU8bCHfexK0n440058W1ACBuFq0nBFqF3gya56pG6aH2D0HiXezhrpzHmPplxwaqnuK8T1TT
	c6gRw==
X-Received: by 2002:a05:6a00:2d12:b0:7fb:f87d:a0aa with SMTP id d2e1a72fcca58-82a8c39ed6bmr1416593b3a.52.1773983558805;
        Thu, 19 Mar 2026 22:12:38 -0700 (PDT)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409f409sm810571b3a.31.2026.03.19.22.12.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 22:12:38 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH 2/3] ext4: add ext4_fc_eligible()
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <177396306176.3934327.9167241352093307006@noble.neil.brown.name>
Date: Thu, 19 Mar 2026 23:12:26 -0600
Cc: Jan Kara <jack@suse.cz>,
 Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B981C6F-1702-49BB-BF0E-44A3955175EF@dilger.ca>
References: <20260317224638.3809014-1-neilb@ownmail.net>
 <20260317224638.3809014-3-neilb@ownmail.net>
 <gh7e7uykczpyhfxrh6y54c2jlcs4pzcud65aqsjoj4am6cajzp@wq26crdxv2yd>
 <177396306176.3934327.9167241352093307006@noble.neil.brown.name>
To: NeilBrown <neil@brown.name>
X-Mailer: Apple Mail (2.3864.100.1.1.5)



> On Mar 19, 2026, at 17:31, NeilBrown <neilb@ownmail.net> wrote:
>=20
> On Thu, 19 Mar 2026, Jan Kara wrote:
>> On Wed 18-03-26 09:39:50, NeilBrown wrote:
>>> From: NeilBrown <neil@brown.name>
>>>=20
>>> Testing EXT4_MF_FC_INELIGIBLE is almost always combined with testing
>>> ext4_fc_disabled().  The code can be simplified by combining these =
two
>>> in a new ext4_fc_eligible().
>>>=20
>>> In ext4_fc_track_inode() this moves the ext4_fc_disabled() test =
after
>>> ext4_fc_mark_ineligible(), but as that is a non-op when
>>> ext4_fc_disabled() is true, this is no no consequence.
>>>=20
>>> Signed-off-by: NeilBrown <neil@brown.name>
>>=20
>> One nit below, otherwise feel free to add:
>>=20
>> Reviewed-by: Jan Kara <jack@suse.cz>
>>=20
>>> @@ -557,16 +548,13 @@ void ext4_fc_track_inode(handle_t *handle, =
struct inode *inode)
>>> if (S_ISDIR(inode->i_mode))
>>> return;
>>>=20
>>> - if (ext4_fc_disabled(inode->i_sb))
>>> - return;
>>> -
>>> if (ext4_should_journal_data(inode)) {
>>> ext4_fc_mark_ineligible(inode->i_sb,
>>> EXT4_FC_REASON_INODE_JOURNAL_DATA, handle);
>>> return;
>>> }
>>>=20
>>> - if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
>>> + if (!ext4_fc_eligible(inode->i_sb))
>>> return;
>>=20
>> Here I think the !ext4_fc_eligible() check could be actually above =
the
>> ext4_should_journal_data() check - if the fs is not eligible for
>> fastcommit, there's no point in marking it ineligible again...
>=20
> Both you and Andreas have questioned that choice - so I should explain
> my reasoning.
>=20
> ext4_fc_mark_ineligible() is NOT a no-op when the sb is already marked
> ineligible.  The code updates sb->s_fc_ineligible_tid to the largest =
tid
> which was ineligible for fc.  Then it only clears the "ineligible" =
flag
> after that highest numbered transaction has committed.  If we skip
> ext4_fc_mark_ineligible() because EXT4_MF_FC_INELIGIBLE is already =
set,
> then that flag could be cleared too early.

You are right, I didn't understand the ongoing effect of FC_INELIGIBLE.
As you write, checking ext4_fc_eligible() afterward is equivalent, since
ext4_fc_mark_ineligible() is itself checking ext4_fc_disabled() =
internally,
so the added overhead is the ext4_should_journal_data() call, which =
looks
pretty complex but is just a bunch of bit field checks (though =
potentially
adds a lot of branches depending on the frequency of the branches).

Cheers, Andreas

