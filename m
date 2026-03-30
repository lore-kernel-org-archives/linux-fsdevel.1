Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7263A6B6C
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880282; cv=none; b=LypsGqI98e7+3QWldNiA/f5tK2Uow9m6BZBq2/m0Diubudn6oJp37jbpSzCT3uXLUbPqaHTVcp9nKjyM2DbSUKt3GwvxyHwN0ivoGGnUFhxm5TbJ53abeWoPXdPwaD5LA6Umgcrd7oKT2/G0HEnfC5eu1tRfyGFrSn7JgN+Ofzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880282; c=relaxed/simple;
	bh=rOOLj9KInFY84LZLkn7IvmDSndtm03eBqF1vHhIp9DM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UBpFPHxPhsdsyraincJHu7+CrZX7MqQIyAiyxyO1xiAZGNNc4fBtD6pYzsIjYBfJkZPiFwfoQcB4YrUI+xeh+GIVgztncl9Ry0QRkStxPeAndmqKnb/ljCADMynNSVNZ+Ieyxy6cvcL6H2Ve0od+bgPy7mcFfpN1Vs+OQ4V931I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=De/5BqfW; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="De/5BqfW"
X-KPN-MessageId: 3fed1372-2c43-11f1-89dd-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3fed1372-2c43-11f1-89dd-00505699b430;
	Mon, 30 Mar 2026 16:17:57 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 3feb5623-2c43-11f1-b5d0-0050569981f5;
	Mon, 30 Mar 2026 16:17:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=hwvkfJ9YepGELUUDReePIG7tSHxcSRFHpIpUcgSLWfA=;
	b=De/5BqfWMav/58OTJSIYztUgp2b77XQhYQ6+VudthOq80mTaRJioJYiWiYDFS6UmIN8NRKJz5LjPZ
	 Sq6Mpv1QIHKBy3Pwj8x86NANH1j4OQ8VlHLA+yB/rOHJB2H989MSh+aYzaE4z0HUDMXaf1/QJ0vdxF
	 0V435mMu+ro8vHoE4zJrb4TS3dybZVa5aTA9QY2qzfu6bRTGPW6EHtmVYttxyScuNwX3wsPLsJpIUL
	 swlp8YZr8EgYj2AFwr9QU1pF9qC9GMEO7kcAYVpjMDy3wpMaHnjRYUNfBB8K3VwexGOUQjm+JBAf8H
	 Wo4j9QQNknqxSluw1GZCOi4V/FAGZVw==
X-KPN-MID: 33|W5YEL+/rdzClRiaFl4acAU2SJ8XhNT7k1xKyV538N3Os2NUmYeTykvb8faP77C9
 cTPMISgmivGPEmhH13s/zlLrxIA7NZ6AEAn+nSrHDjxs=
X-CMASSUN: 33|9XQ4qwIxI6xmQnV6cxoqdUbBbVHFMUr+/hH1E8HRjysRyEtV5v+5lvwAqr2G5tm
 m4u4LgF7eTPLeFv0kJSdqhg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 3fd7cef1-2c43-11f1-94b1-00505699eff2;
	Mon, 30 Mar 2026 16:17:57 +0200 (CEST)
Date: Mon, 30 Mar 2026 16:17:57 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>,
	Penglei Jiang <superman.xpt@gmail.com>, Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Message-ID: <2061092696.506085.1774880277070@kpc.webmail.kpnmail.nl>
In-Reply-To: <ecc86514cde4732995d9f50b9f5071fbb1f675e4.camel@kernel.org>
References: <20260326182033.1809567-1-jkoolstra@xs4all.nl>
 <20260326182033.1809567-2-jkoolstra@xs4all.nl>
 <ecc86514cde4732995d9f50b9f5071fbb1f675e4.camel@kernel.org>
Subject: Re: [RFC PATCH v2 1/3] vfs: add support for empty path to
 openat2(2)
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


> Op 30-03-2026 14:12 CEST schreef Jeff Layton <jlayton@kernel.org>:
> 
>  
> On Thu, 2026-03-26 at 19:20 +0100, Jori Koolstra wrote:
> > To get an operable version of an O_PATH file descriptor, it is possible
> > to use openat(fd, ".", O_DIRECTORY) for directories, but other files
> > currently require going through open("/proc/<pid>/fd/<nr>"), which
> > depends on a functioning procfs.
> > 
> > This patch adds the OPENAT2_EMPTY_PATH flag to openat2(2). If passed,
> > LOOKUP_EMPTY is set at path resolve time.
> > 
> > Note: This implies that you cannot rely anymore on disabling procfs from
> > being mounted (e.g. inside a container without procfs mounted and with
> > CAP_SYS_ADMIN dropped) to prevent O_PATH fds from being re-opened
> > read-write.
> > 
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> 
> Looks sane to me. Can this be merged apart from the rest of the series?
> It doesn't seem like the transitive stuff is dependent on this.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Yes, there is no dependence. However, Aleksa suggested that we DO add it
to openat() as well because then systemd folks can use it too. I don't
if there are any objections to that right now.

Thanks,
Jori.
