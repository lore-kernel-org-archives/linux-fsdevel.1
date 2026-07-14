Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF3343D7F
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 04:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002535; cv=none; b=f2bubaFXPATTeVjPa9qXjeqN+QTwkdts9rSmgaitLDy0034XITvd9zm8zwfs8ab1QWGdZPukO1YlQqyMuxf6XoIJsy70fiROQhdX7s41++VhUuBmzafsO+10ZT8IplX7WX4lPgBP6caApe7yu0aMaBkPTYMtpLocha0zTy6Gm2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002535; c=relaxed/simple;
	bh=vJrxMfVwbCIAJH/l2/d4/earlMFVUXka6g/p9DJdDXw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rG9XTD7CWLEh78FYvc5KZZ+npW7FirVic2O0wAfkzSCEhkJXnRzag9NZbFMObSvZBvjotPHOUWflDOKdD8raM+t/s7G2qqAw0IBjXQvGs2rIQOfvdZr2NXaXZl9J34GYveraHkRl6VhHSfxIQiIYLbhDpKdgkwm+ikG+giswehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=iIQ6xewQ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="iIQ6xewQ"
Received: from macsyma.thunk.org ([151.240.45.25])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 66E4ErRC025390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 00:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1784002496; bh=MV2PppsIiMWqIO+DNMAc6xCQwmADIksnc8DCtHjHJMI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=iIQ6xewQv08RpAocToswgcb8vVJMxz9k1bD7fceVk+A763UEO24mt1+/b4GT46IUP
	 NjyJieu6TJDOGhozlV65RysZm4E3muBfUP+LbD195TGkwOfl7L8+0jRUOBOouRE5U9
	 65+kNDdOgNQt6azYCU3QJwFW1IP0hig6PB4toXyhgVLpuKTTA6hVYVmB+UL7f1KwdN
	 1vAPffzNJ2Zo4MNONM3va4Pn8ZoMipvUYJrHNF9LIPi6H54YfxiZnmFZEwrKEYI+/s
	 QRoPyEdQkxJ4neHEVUTgyE87/s+E4L1Wxzh51941RJYYZSZzPNaylQiRwy+N3lYpzr
	 SMgrWzkHYZEMw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id C5547A04BAB; Tue, 14 Jul 2026 00:14:53 -0400 (EDT)
Date: Tue, 14 Jul 2026 00:14:53 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, ksummit@lists.linux.dev
Subject: Maintainers Summit 2026 Call for Topics
Message-ID: <alW3eJ9x6iJ8Juhi@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This year, the Maintainers Summit will be held in Prague, Czech
Republic on Thursday, October 8th, 2026, just after the Linux
Plumber's Conference (October 5 -- 7th).

As in previous years, the Maintainers Summit is invite-only, where the
primary focus will be process issues around Linux Kernel Development.
It will be limited to 30 invitees and a handful of sponsored
attendees.

The Maintainers Summit depends on the development community to bring
forward topics that can benefit from discussion in that setting.  What
are the nagging development issues, pain points, or other important
decisions that are not amenable to resolution on the mailing lists?
If you have a topic in mind, please send it to ksummit@lists.linux.dev
with a subject prefix of [MAINTAINERS SUMMIT].

The attendees are jointly selected by Linus Torvlads (who has provided
us with a roughly a dozen maintainers that he would like to attend),
and the program committee, who choose from maintainers and developers
who have been the most active in the past year.

Anybody proposing a topic before July 24th will be added to the list
of potential attendees selected by the program committee; other
potential nominees can be proposed (as a self-nomination or by others)
by sending a note to the ksumimt list saying why that person's
presence would help the discussion.

For an examples of past Maintainers Summit topics, please see the
these LWN articles:

 * 2025 https://lwn.net/Articles/1049982/
 * 2024 https://lwn.net/Articles/990740/
 * 2023 https://lwn.net/Articles/951847/

The program committee this year is composed of the following people:

Christian Brauner
Jon Corbet
Greg KH
Ted Ts'o
Rafael J. Wysocki

