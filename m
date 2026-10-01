Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84A84963D2
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870375; cv=pass; b=JLCFk5exvAxfhi/qOn2ngNeX0jzD+5yjBdM18F1WaEQoF5zpDDW1OWD5YJwL+GmmeFFGxOjRLxVSmodlk03UDw3IyLx5ACfHInB6p99f/waU2PcvOIt9d4jypKFUfxnu1Uv4L1uSKRIPpkAV1XYG66H+op4aVWnVTKDzXbs9G1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870375; c=relaxed/simple;
	bh=WzhH+AtHGPtHiPjBQHHacP5urFUcd2FtjAYYwProfL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFiOpQuDzlo7JgBvAFM77uxdHKXdjw5CjPAOQLQ7f/jC1+1qzwpcoBybg/Jg4g51YGSWQxminGeiAH8GADV5NsK/94e5w229Mu5vpnUAV0IlRFg5YqPIxdpRGz9xQFCW04FiN6SFOgTTKhG2m46qGNmbooqjJ4oocNxRz/NHvG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Orol+tSZ; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Orol+tSZ"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6aeeccb7d59so1304579a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 08:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870371; cv=none;
        d=google.com; s=arc-20260327;
        b=oMOem9v1MZu4uSpOWeJ1gIo/TYswkPrpSXy/24WqAxZTvkufxmNMJtaWo3MVHCTx9r
         TvKKwG22nJK0eq42qjMCLWa81+g9U6/tYzAIwUAnuK+bQO9Lcu6aUr/+eUtdpp7GyxtO
         u0oeuNAO8b2z63KBbWTWo7emgynB+Xy7gqO6cKuevaKXxMODd5btmPpynrLYinz4ADHZ
         pkJa3O4p8eQhl24T8DHqUA9kMNpB7X2BWSszZSmPG7e0c1Jc3DbPlGQlzOO3Zwd6R5O7
         6t366USwBGoEEwnoX/r6EtuEg+4Bb4/7Ju9F0oIYk5uPCIHNW2Hveqb9nU2n0f52FIKQ
         Y63A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WzhH+AtHGPtHiPjBQHHacP5urFUcd2FtjAYYwProfL0=;
        fh=oFp5QHJCSKZtLFR5Tz1onCyvmC1bEmTdstigW/mncNs=;
        b=jEOZA93bselfyn5PwhKHezZmNnBU8wqg4xO6phpwCQN+aPwoAdZcZR5gm2C/cA3zee
         njUBL9ayABT2VLoWGiN9u5j8WEuBH6B9if+/OHqdTA9B1A1ojG7L0b1hC+uvaOBEk1oh
         V4h4lJ/YB5wjQ1QXZ2NlEmi1JOiel/zGbZxBvdi/MeDmhNcOMHgMpO2HWTSDiv9H0wnI
         wTjkFKT+y2N2SjjYR2alUGWgfQnHraaPWPQ67kwLhqqKzdC+AaSqoSjliCh48jkJ7He6
         FG8wQbKUCMFdOTg7f7UuyELruFKqIIP3VjtjmsaSZv/cYBU8fefy5WXsfusEVkn/EBi6
         G0Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790870371; x=1791475171; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WzhH+AtHGPtHiPjBQHHacP5urFUcd2FtjAYYwProfL0=;
        b=Orol+tSZBNLX9gZGMk4VE7FB4y5rq4WvOH/SMMYTZ1tayK5cGqICbAZloM0N8PA3GV
         oQK/aRtbF4/NFvOdiFWkZ24lpA/mOlH0KVcSMo+7povFut8nRiJOBmGDSxUOSZw44E2y
         EZWV6V2tmeZgGWIFtMldrGaisnKqcSuKnQvmLflUtdkYaoS+kk5MlkittbehSTC90QG/
         TCSKJd576x5AZp48CNphv8ogFSKoH2DIq8wnFtTM5SItZGAPJnhNBCOUgs4wwnHUTiNh
         Eu+/Mkf97kDcpEjtAad9qT7mt6LlMi4bdkLJguR8UWziQ9IYQsIGXgxCdQXMpBw5Yo/r
         CBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790870371; x=1791475171;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WzhH+AtHGPtHiPjBQHHacP5urFUcd2FtjAYYwProfL0=;
        b=s5tNULSGJdx7mNNkWCw7444pCREGImaBxkhhVm9ZimY3StAMcIRndMvTUvQuWaUe7x
         5ZpXRs1Ai5zYm3ZWW0R9sNw1CVSnPuC8AHFP3h1/cza8VJPoarLDLWxS7ZyHQjN9AK5L
         6oWWg9YVheYHTKGAe3xNABQYro6qC4FlVqjPTN0RB8HhIuadNLIhjDurAzkYsG9slyz9
         2sLKNpvk7Dt3ouqE2sYNOwHyiQ/HZCrrrNzuCy2K4GF5h+g3wapeRaqyRYuScvZ4lKWQ
         DydW9liTecGLRnmSQ7oREU5j8aekZN6eDFO+wwqL9/hVFbpmr6V1xB0pQZ7mlGXNO/Xs
         Rb4g==
X-Forwarded-Encrypted: i=1; AKwUvBzfSbpQKg8pKIe12OIB7dZcwajuNAqYmKJVbuvWv559Hph8uzWuSOK98vPjHq8nrHsHITY9TuPmPY+1iEtW@vger.kernel.org
X-Gm-Message-State: AFq9FYLeM/ZypZVre6qmdLuOVXI4AnDrykxa+0lq4AS98hkDUI06Vfy1
	XxndeTv/lI8gNuDgFeZ0bXA8poMua/MI6f7+OtY8mRy+dx4YzKsLVowk4d3kR2/t32FRybgMGYw
	vPHlgq2CoOL33GO0KWHr+damkJEAciHc=
X-Gm-Gg: AYBFou0V6FLrtOGztxBOHo4oKsnJ1HEGqvK2MvH0LVhI4aCVXTZVgE3uD8IV+XAFf40
	fxNuixIaXWAQtUibojWiTncudyGfnjDK3Xy6n+hlZg7ycckQI3JL3H98qeehKMH3ukL7/7hm5/y
	Lbegc1V+ROCN7jP1Oi2cOKIc3EE9Tn4yMIfo6pmiMmqxBnzL6AjsxHycNbI+HRTsGLyOhCJHgZV
	vf4iycPM02x8hoMP6boDvIezqT8omBPY6CbZ+FUHsQhj0NlNbxsYJon4ewO22AOUVMgtN+kEpwk
	1AmGABhc0T4icq1Ay4FMANBzgSKZwNo953BpOC4/pRqymw4kbddeW4px4ny1iDwpiUU=
X-Received: by 2002:a05:6402:a544:20b0:6af:92a6:97df with SMTP id
 4fb4d7f45d1cf-6af92a6a414mr619051a12.0.1790870370498; Thu, 01 Oct 2026
 08:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913185016.523376-1-jkoolstra@xs4all.nl> <20260913185016.523376-8-jkoolstra@xs4all.nl>
 <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
 <178972607557.207413.4312278359822083538@noble.neil.brown.name>
 <178977609418.207413.15011378414000392029@noble.neil.brown.name>
 <1010887891.582666.1790682845752@kpc.webmail.kpnmail.nl> <179072013439.37859.465558431050704411@noble.neil.brown.name>
 <CAOQ4uxis4tsea6fx+9iAffVX+qwBC9KzHg5GcP7ahthKd1T9KQ@mail.gmail.com>
 <1910540525.790746.1790806610320@kpc.webmail.kpnmail.nl> <CAOQ4uxhYHf-gAkjdhs37vZREOcNds5a_6c3nBX0Lva3resofmw@mail.gmail.com>
 <1000409963.929534.1790869356300@kpc.webmail.kpnmail.nl>
In-Reply-To: <1000409963.929534.1790869356300@kpc.webmail.kpnmail.nl>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Oct 2026 17:59:19 +0200
X-Gm-Features: AclHuK_3dF_O5lWW3SdzB7Kw85o723RVTI5tcpk87Y2IdVrsLp_0nrCYqG-LJ64
Message-ID: <CAOQ4uxism8-zwCDgGjO4Rxz6DqOkZJeZOeYKHf3QaBDFZHpcFg@mail.gmail.com>
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Aleksa Sarai <aleksa@amutable.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"

> > Maybe I am missing something, but I think you misunderstand me.
> > What I mean is - if directory inode has a ->atomic_open() op,
> > bail early with -EINVAL/-EOPNOTSUPP, because this is a network
> > filesystem that does not support atomic O_CREATE|O_DIRECTORY
> > and in most likelihood never will support it.
> >
> > This gating criteria is not dependent on cache state,
> > which is what we wanted.
> >
>
> No in that case I think I've understood you (or maybe still not?) My
> point is that we can't do that if we want to be able to individually
> support O_CREAT|O_DIRECTORY for some ->atomic_open fs. If we bail early
> the how can say only NFS support it at some point? You get into the
> situation where everybody needs to have support or no one.
>
> Does that make sense, or do I still misunderstand you point?
>

If we gate on an existing criteria now like ->atomic_open()
and/or ->d_revalidate(), we keep semantics simple and it
does not limit us to change the criteria in the future.

But I don't insist on this criteria - it's just a suggestion.

Thanks,
Amir.
