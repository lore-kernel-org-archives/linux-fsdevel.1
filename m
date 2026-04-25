Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCD27E0E4;
	Sat, 25 Apr 2026 02:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777084713; cv=none; b=CbctEl0veNNXN4x1qyHl2D8qodH2NvlJ4mtaYTNg1l15qeo+BYqaUtMaaPfgnZ1Fy6W8I+iy8tZNr12JFjVX5Krs7nQNimqzuiN5fBwiLFfhg5c/mTYxbPQYOgO7iDNzZO2HPfO1lOEDQN9sQxJ89XBD4NcFRnIwNhXGkcsZ80c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777084713; c=relaxed/simple;
	bh=Xkr4hkQYzf2Mgkyx8eU3WeAN+0E7lQKoPraoiZXJstY=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=fMPcUd//3ChZd708x/60GXymb3d7TJ8t0KSNmfB3KPeiKgywgL6xYc02nfhWVAh8Fj2Syts9hAQjCXQMly2sDL6vm80Xztkyw4Vfwwoj4tz4oHfgtfQphtzRI4fXTIISyqAs1FHc66hiMA0BnbzIJRSoh4Ao10t4Gzzf5awf3UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf10.hostedemail.com (lb01b-stub [10.200.18.250])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 6463E1C004B;
	Sat, 25 Apr 2026 02:38:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id E9AB141;
	Sat, 25 Apr 2026 02:38:27 +0000 (UTC)
Message-ID: <d9cbb89faa5bdb71d451781d214a51ce8923a83e.camel@perches.com>
Subject: tools/testing/radix-tree/maple.c & vs | defect
From: Joe Perches <joe@perches.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Alice Ryhl	
 <aliceryhl@google.com>, Andrew Ballance <andrewjballance@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date: Fri, 24 Apr 2026 19:38:26 -0700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: tpaadg5g6m9tbhqww55sau9i8hemmspf
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E9AB141
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX194umgHdIYoRNTpdu9d/3eZyUORtsdGRtQ=
X-HE-Tag: 1777084707-41909
X-HE-Meta: U2FsdGVkX18LeMnRkpOCimFx/8VLdJRKH1py04izRhSyBzAyo3q6uSc+k2t4J5m8EMMIiO8425IdFvdUpi2Qf8HLq8gMxvYVJGyVw3Zfj6cexdS3YIXky+0OtZOslPEqrTYONh7RK9nhEJMzcCmOrncqP/du51X8NzNCEan4reChKsFpzx9xWcD9eXYYPqiWF5wfB5/ftaABabllo145EYKsYwBaQGxlwPnSyDrj6SnctuuEMM+fB/xS9KqgDsE2tqjgNhd0xyTAo09L2xAVPOE5W16iL+STfDvcUJS7DTcnuQ9MCo/UjfYis46+kq/o

tools/testing/radix-tree/maple.c:       MT_BUG_ON(mt, mas_preallocate(&mas,=
 ptr, GFP_KERNEL & GFP_NOWAIT) =3D=3D 0);
tools/testing/radix-tree/maple.c:       MT_BUG_ON(mt, mas_preallocate(&mas,=
 ptr, GFP_KERNEL & GFP_NOWAIT) =3D=3D 0);

Presumably the & here should be |
