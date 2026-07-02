Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B62253EC;
	Thu,  2 Jul 2026 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974866; cv=none; b=sTUX7hk3gS6iVKQcCOf4q73rdzY34CGbY2gqQy8IZoapmzdcrlGGk2Epg9JYwzdHvUfDzfWRGFImmwvVYkdns0+QprBMDmrlEztI4J2u55KvVegp+4+LKdt3frUXgQgwJegq0PoSUxxPqn5KdoZQrwLigiljoGfI877j/bn+F1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974866; c=relaxed/simple;
	bh=oa5Qf/ud/+4bj1hyAPt285Dz6V5xOglurUWZlDnFojM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=MmwsMu052BoW3E71DflcSVPkJ3/mvCftdiJucHrP2V6lbVBXwTHLpjLO3JqsqTIKkscfsOoyTizMuzi8tobmRrY0pkRNPucv/tzZ06Dg8K+9SPloI5VQJ9ZkC0DFj0DhBXuX/2WAmrTuc1Ryy68A139x8/CPWKy88r85T+h7KtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE6I4hWl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE6I4hWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED6A1F000E9;
	Thu,  2 Jul 2026 06:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782974865;
	bh=cHq52KTdAgH/acxSyT/FmFqrs1kz1XA3jG8c8Okbrtc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=VE6I4hWl/QVnpCZpCZd0xz6YScI8zEpgOn59SY7yge7uw7li/KF6JJe0wOURiRGR/
	 FB7yd3bt0lbMGrzohcnomjf3GppFU1Xa+qBwseqsgGkpttzG8oOlH1dXUitlSUCc7G
	 AGY+0FfriliNoJ6VSoBA5fFCTUFWeWg5Lq4Ep/YvFavPZJfKHxvntNvWfW+aLtjgHT
	 JLu+X3pN2UsZdEUVXim0d6RuKsqgbv1IS8MPTblGEtzxOwzcM1VYyMGpJX7l3quYxz
	 PLQRt6DVTBdC/jb5ls+q03rS3RcPxmoYCCp5ySwm1VQDh7IGPFQ8sBe60T5G97GGEx
	 f85Rm0buMLKKQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] fs: support $ORIGIN in ELF interpreter paths
From: Christian Brauner <brauner@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
 John Ericson <mail@johnericson.me>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 shuah@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
 linux-mm <linux-mm@kvack.org>, 
 linux-kselftest <linux-kselftest@vger.kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CACCo2jkA=HajHww=Ysf+cg+LLTg8y1eHd3MZVJqCGtHryzT6CA@mail.gmail.com>
References: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
 <sfv7zc6jboy2oxv7zuyofysas4ncbzenwsuzveiyduisfr6i7q@mx23er7uxdbg>
 <CACCo2jkDuwy5w_yhX8833m+s-rY736pk8xtKjxg3_y_7BCOHeg@mail.gmail.com>
 <24420045-a6eb-4999-ab19-1e344eaba8a4@app.fastmail.com>
 <20260625-atomkraftgegner-hunger-kursbuch-b452ff2becab@brauner>
 <CAG48ez2X1p5Nm2_sU=SK9wUusUO8c3_T-=FGrrOhkm7Kn9Y_7g@mail.gmail.com>
 <20260628-ungeordnet-orgel-stechen-36dd64038541@brauner>
 <20260628-debatten-vertagen-amortisieren-3bf518773e75@brauner>
 <CACCo2jkA=HajHww=Ysf+cg+LLTg8y1eHd3MZVJqCGtHryzT6CA@mail.gmail.com>
Date: Thu, 02 Jul 2026 08:47:39 +0200
Message-Id: <20260702-taktieren-entbunden-feldarbeit-6063175a9ef0@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=496; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oa5Qf/ud/+4bj1hyAPt285Dz6V5xOglurUWZlDnFojM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5cfbph6pNfKqgOCdbPn2T5qfIPb0hbuXTOOcktKQHl
 887e3NuRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQe2TH8L+H185t8xufKLN1P
 4eYfv2hYJl/U27BPt6v1z+5ugTCGHwz/y36HHujZvLX6dcxny8tmgjcOTrr3rpt9J++OvJWrDkY
 EcQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Anyway, I digress.
> What other options are there to go after for a relocatable binary? The
> steps wrap-buddy has to take... are a bit horrendous in practicality
> (although amazing from an engineering-sense).
> 
> binfmt itself is configurable and modules can register additional exec
> types. What about something similar for ELF & INTERP ?

Not sure if my message made it yesterday. It somehow seems it didn't so
I'm repeating it: let's look at the code for what you had in mind.

