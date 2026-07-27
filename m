Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27853ED128
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155770; cv=none; b=S14nV3gZhHEREx3D3gQOZzFC1LqKH4wM3hUHv4Jnw8QT3oPLYhkcsvWl3ngPv2yhTn64uZWNv8qCa/Wyt6WgnhDdNIAf/5+cUvGpQ+HuhI6dPsUfm3yZk+uQYARsTBCQX1imkl7n1CEnnq1Dvig+3MAKypiE2UiLRF4NDpDyTWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155770; c=relaxed/simple;
	bh=8lluyG/o4XeTP4X3a03AUoWg0O0M6YnhCE5LDnhu8Ts=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=tgtuuaUXYRUbiYB9rYKom33WrI61nN8RAqUGSz1Th8+65DVpaJ4eUYPkGvq5sEA1bICA9M6MIb5dhyMV/1k0uFhEgtC0KCJ6vG+1e/6GukbTYohMqavtsI//xxxD4osl8AQPYOtW+BSWp4lSvdNRS6dY8C1B8iCJUnxrlR39TaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgOJAgFd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgOJAgFd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785155767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lluyG/o4XeTP4X3a03AUoWg0O0M6YnhCE5LDnhu8Ts=;
	b=SgOJAgFdN2xkLf491AbYA3jxgRRpl5tYgI63vGxiKfQtjQqKhiRzr1bRE6EneEd7Mmequm
	zIep6an5zqeCWGXA3ON5uNXHj6ysK+WclOmCJWhcX15p6ZqziP4c5FjqA0veJ6SQh7tMOP
	gKbAhXrnb52VTqIuhQejTYZOsVyUk5Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-UXdWTtrlPGSL4LQ43z91aw-1; Mon,
 27 Jul 2026 08:36:04 -0400
X-MC-Unique: UXdWTtrlPGSL4LQ43z91aw-1
X-Mimecast-MFC-AGG-ID: UXdWTtrlPGSL4LQ43z91aw_1785155763
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEDE019540EF;
	Mon, 27 Jul 2026 12:36:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BFD61800480;
	Mon, 27 Jul 2026 12:35:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6a4c21b3.c76b52dc.34afef.0002.GAE@google.com>
References: <6a4c21b3.c76b52dc.34afef.0002.GAE@google.com>
To: syzbot <syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
    pc@manguebit.org, Yun Zhou <yun.zhou@windriver.com>,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] WARNING in netfs_writepages (3)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1098524.1785155757.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 13:35:57 +0100
Message-ID: <1098525.1785155757@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git netfs-fixes

