Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CFF22A4EE
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854823; cv=none; b=ZPAMxW6Pvl1SKIq1revGHJM53q1uOLuxwF+vJnjvOeW7oxgwBmsCWmkgzj4ACQbXhgqXDQoJnE2EcnN9n+H+2ZsVcxnLh1dFsy/9wiJE6OzdtOxn9WNc/aH8Ds/gJ19oqC3KRIAy/vaWUxp2SLUYwUNxui9sPRh4W2MskY/tK84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854823; c=relaxed/simple;
	bh=ILFmbUAjhO8n+FbPS46ubKWXbMgNzkQMhJSA/3oPzy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn1MtaV8YK27Fa2FJ+dagclY6Uwttlx+WxxFQq731pIVcYm06fTJDr01n8sXflnAcWRav+KqyROchoVSkO4NfWbASBqaGgu2H7TSPrabsL3lj9jTqAIik9ByjfC7STDDI6YlpVkMm4qbBYU+Hec+r+CBZmg8MyNxugtOZOjsmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3FEF868AFE; Mon, 23 Feb 2026 14:53:39 +0100 (CET)
Date: Mon, 23 Feb 2026 14:53:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Keith Busch <kbusch@kernel.org>, jack@suse.cz, amir73il@gmail.com
Subject: Re: [LSF/MM/BPF TOPIC] FDP file I/O via write-streams
Message-ID: <20260223135339.GA17313@lst.de>
References: <CGME20260220110725epcas5p41a6ae8751fee9782f338cbd66dd2700d@epcas5p4.samsung.com> <83f2e586-75d8-44a3-8427-ea6165f1dff9@samsung.com> <20260220151137.GB14064@lst.de> <ee9893dc-986b-403e-8ba9-5fe4670459b6@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9893dc-986b-403e-8ba9-5fe4670459b6@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Feb 21, 2026 at 01:21:38AM +0530, Kanchan Joshi wrote:
> On 2/20/2026 8:41 PM, Christoph Hellwig wrote:
> > I think you'll get much better traction if you don't tie a high-level
> > feature to the buzzword of yesteryear as one possible implementation.
> > 
> Let me confirm my understanding. Perhaps this is about using the term 
> stream in the UAPI naming (i.e., FS_IOC_WRITE_STREAM ioctl) and the 
> concern is that it reminds of the older NVMe multi-stream (streams 
> directive) feature?
>

It's about your use of FDP in the subject.
